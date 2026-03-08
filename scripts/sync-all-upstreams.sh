#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MANIFEST="$ROOT/UPSTREAM_SOURCES.json"
WORKDIR="$ROOT/upstream-sync/work"
REPORT="$ROOT/SYNC_CHANGELOG.md"

mkdir -p "$WORKDIR"

python3 - <<PY
import json, subprocess, pathlib, re
root=pathlib.Path('$ROOT')
manifest=json.loads(pathlib.Path('$MANIFEST').read_text())
report=['# SYNC_CHANGELOG','', 'Automated upstream sync report.','']
changed=False

for src in manifest['sources']:
    sid=src['id']
    repo=src['repo']
    branch=src.get('branch','main')
    pin_file=root/src['pinFile']
    clone_dir=root/'upstream-sync'/'work'/sid

    if clone_dir.exists():
        subprocess.run(['git','-C',str(clone_dir),'fetch','origin',branch],check=True,stdout=subprocess.DEVNULL)
        subprocess.run(['git','-C',str(clone_dir),'checkout',branch],check=True,stdout=subprocess.DEVNULL)
        subprocess.run(['git','-C',str(clone_dir),'reset','--hard',f'origin/{branch}'],check=True,stdout=subprocess.DEVNULL)
    else:
        subprocess.run(['git','clone','--depth','1','--branch',branch,repo,str(clone_dir)],check=True,stdout=subprocess.DEVNULL)

    head=subprocess.check_output(['git','-C',str(clone_dir),'rev-parse','HEAD']).decode().strip()

    old='unknown'
    if pin_file.exists():
      txt=pin_file.read_text()
      m=re.search(r'commit:\s*([a-f0-9]{7,40})',txt)
      if m: old=m.group(1)

    report.append(f'## {sid}')
    report.append(f'- repo: {repo}')
    report.append(f'- branch: {branch}')
    report.append(f'- previous: {old}')
    report.append(f'- latest: {head}')

    if old != head:
      changed=True
      # Update pin file preserving existing metadata where possible
      pin_file.parent.mkdir(parents=True,exist_ok=True)
      if pin_file.exists():
        cur=pin_file.read_text()
        if 'commit:' in cur:
          cur=re.sub(r'commit:\s*[a-f0-9]{7,40}', f'commit: {head}', cur)
        else:
          cur=cur.rstrip()+f'\ncommit: {head}\n'
        pin_file.write_text(cur)
      else:
        pin_file.write_text(f'repo: {repo}\ncommit: {head}\n')
      report.append('- status: UPDATED')
    else:
      report.append('- status: NO_CHANGE')

    report.append('')

report.append('## Summary')
report.append(f'- Any source changed: {"yes" if changed else "no"}')
(root/'SYNC_CHANGELOG.md').write_text('\n'.join(report)+'\n')
print('changed=' + ('1' if changed else '0'))
PY

# run validations after sync attempt
bash "$ROOT/scripts/validate-skills.sh"
bash "$ROOT/scripts/validate-skill-template.sh"
bash "$ROOT/scripts/validate-skill-descriptions.sh"
bash "$ROOT/scripts/run-compat-acceptance.sh"

echo "SYNC_COMPLETE"
