#!/usr/bin/env python3
import json,re
from pathlib import Path
root=Path(__file__).resolve().parents[1]
skills_dir=root/'skills'
corpus=json.loads((root/'tests/prompt-corpus/bridge-routing-corpus.json').read_text())

def desc(k):
    t=(skills_dir/k/'SKILL.md').read_text()
    m=re.search(r'description:\s*"([\s\S]*?)"',t)
    return m.group(1).lower() if m else ''

skills=[d.name for d in skills_dir.iterdir() if d.is_dir() and d.name.startswith('ecc-')]
descs={k:desc(k) for k in skills}
rows=[]; passn=0
for s in corpus['samples']:
    p=s['prompt'].lower(); pref=s['must_match_prefix']
    toks=[w for w in re.findall(r'[a-z0-9\-]+',p) if len(w)>2]
    best=None;score=-1
    for k,v in descs.items():
      sc=sum(1 for t in toks if t in v)
      if sc>score: score=sc; best=k
    ok=best.startswith(pref)
    passn += 1 if ok else 0
    rows.append((s['prompt'],pref,best,ok,score))
rate=round(passn*100/len(rows),1)
verdict='PASS' if rate>=50 else 'FAIL'
out=['# BRIDGE_ROUTING_REGRESSION','',f'- Samples: {len(rows)}',f'- Prefix-pass rate: {rate}%',f'- Verdict (>=50% baseline): {verdict}','', '| Prompt | Expected Prefix | Predicted | Match | Score |','|---|---|---|---|---|']
for r in rows:
    out.append(f'| {r[0]} | `{r[1]}` | `{r[2]}` | {"✅" if r[3] else "❌"} | {r[4]} |')
(root/'BRIDGE_ROUTING_REGRESSION.md').write_text('\n'.join(out)+'\n')
print(f'pass={passn}/{len(rows)} rate={rate}% verdict={verdict}')
