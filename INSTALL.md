# Install openclaw-ecc

## Option A: Copy into OpenClaw skills directory
1. Clone this repo
2. Copy `skills/*` into your OpenClaw skills path
3. Restart OpenClaw runtime

## Option B: Keep as git submodule/overlay
- Add as submodule and symlink `skills/` into your OpenClaw skill path

## Verification
- Run local validators:
  - `bash scripts/port-check.sh`
  - `bash scripts/validate-skills.sh`


## Install Wizard (recommended)

Run:

```bash
bash scripts/install-wizard.sh
```

Useful modes:

```bash
# non-interactive
NONINTERACTIVE=1 bash scripts/install-wizard.sh

# choose MCP profile
bash scripts/install-wizard.sh --profile strict

# dry run
bash scripts/install-wizard.sh --dry-run

# status only
bash scripts/install-wizard.sh --status

# uninstall
bash scripts/install-wizard.sh --uninstall
```
