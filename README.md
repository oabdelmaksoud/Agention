# SuperClaw 🦞

**The OpenClaw power-pack for serious agent execution.**

SuperClaw combines:
- **ECC-style execution rigor** (plan → implement → verify → harden)
- **Agency-style domain playbooks** (engineering, testing, strategy, product, design, marketing, support)
- **Anthropic/Claude skill ecosystems** adapted into OpenClaw-native workflows

If you want your OpenClaw setup to be reliable, scalable, and testable — this is the pack.

---

## Why SuperClaw

Most agent stacks are either:
1. great prompts + weak execution discipline, or
2. strong architecture + weak domain depth.

SuperClaw gives you both:
- execution backbone
- domain specialization
- runtime compatibility
- validation and sync automation

---

## 🚀 Quick Start (2 minutes)

```bash
git clone https://github.com/oabdelmaksoud/SuperClaw.git
cd SuperClaw
bash scripts/install-wizard.sh
```

Then refresh OpenClaw session (`/new`) and run:

```bash
bash scripts/run-compat-smoke.sh
```

---

## What you get

### 1) Large skill ecosystem
- ECC-derived command/role/domain skills
- Bridge skills from:
  - `agency-agents`
  - `claude-skills`
  - `anthropics/skills`

### 2) Runtime compatibility assets
- `contexts/` (dev/research/review)
- `hooks/` (hook-intent mapping)
- `mcp-configs/` (mcporter profiles)
- `schemas/` (validation contracts)

### 3) Automation + safety tooling
- install/uninstall/status wizard
- full test sweep runner
- quality + schema + description validators
- upstream auto-sync workflow

---

## Architecture at a glance

```text
                   Upstream Sources
     ECC + agency-agents + claude-skills + anthropics/skills
                               |
                               v
+----------------------------------------------------------------+
|                           SuperClaw                             |
|----------------------------------------------------------------|
| skills/          -> OpenClaw-ready skill pack                  |
| scripts/         -> install, test, sync, enforcement tooling   |
| contexts/hooks   -> runtime behavior layer                      |
| mcp-configs      -> mcporter profiles                           |
| tests/           -> acceptance + scenario + regression          |
| upstream-import/ -> traceable source snapshots                  |
+----------------------------------------------------------------+
                               |
                               v
                    OpenClaw runtime execution
```

---

## Feature matrix

| Capability | Included | How to use |
|---|---|---|
| Install wizard | ✅ | `bash scripts/install-wizard.sh` |
| Core/full skill pack control | ✅ | `bash scripts/skills-pack-manager.sh {apply-core|apply-full|status}` |
| Compatibility smoke test | ✅ | `bash scripts/run-compat-smoke.sh` |
| Full scenario sweep | ✅ | `bash scripts/run-all-tests.sh` |
| Agent/role scenario tests | ✅ | `bash scripts/run-agent-scenarios.sh AGENT_SCENARIO_MATRIX.md` |
| Upstream auto-sync | ✅ | `bash scripts/sync-all-upstreams.sh` + GitHub workflow |
| Subagent delegation policy | ✅ | `SUBAGENT_POLICY.md` + `OPERATIONAL_ENFORCEMENT.md` |

---

## Install wizard (advanced)

```bash
# Non-interactive install
NONINTERACTIVE=1 bash scripts/install-wizard.sh --profile standard

# Dry-run
bash scripts/install-wizard.sh --dry-run

# Status check
bash scripts/install-wizard.sh --status

# Skip optional pieces
bash scripts/install-wizard.sh --skip-mcp --skip-validate

# Uninstall
bash scripts/install-wizard.sh --uninstall
```

---

## Validation suite

### Fast baseline
```bash
bash scripts/run-compat-smoke.sh
bash scripts/run-compat-acceptance.sh
```

### Full verification
```bash
bash scripts/run-all-tests.sh
```

### Deep quality checks
```bash
bash scripts/validate-skills.sh
bash scripts/validate-skill-template.sh
bash scripts/validate-skill-descriptions.sh
bash scripts/validate-schemas.sh
python3 scripts/eval-bridge-routing.py
```

---

## Skill pack modes (avoid discovery overload)

If your runtime loads too many skills at once, use pack management:

```bash
# Keep core active, park heavy claude bridge set
bash scripts/skills-pack-manager.sh apply-core

# Restore everything
bash scripts/skills-pack-manager.sh apply-full

# Check counts
bash scripts/skills-pack-manager.sh status
```

---

## Auto-update pipeline (stay current)

SuperClaw includes scheduled upstream sync:
- source manifest: `UPSTREAM_SOURCES.json`
- sync script: `scripts/sync-all-upstreams.sh`
- CI workflow: `.github/workflows/upstream-sync.yml`
- sync report: `SYNC_CHANGELOG.md`

Flow:
1. fetch upstream heads
2. compare pinned commits
3. update pin files if changed
4. run validations
5. create/update PR automatically

---

## Proactive subagent delegation

SuperClaw defaults to proactive subagent usage for complex tasks.

Policy docs:
- `SUBAGENT_POLICY.md`
- `OPERATIONAL_ENFORCEMENT.md`

Required in delegated outputs:
- subagents spawned
- scope per subagent
- result per subagent
- merged final decision

---

## Common use-cases

- Standardize delivery quality across many OpenClaw sessions
- Add enterprise-style plan/verify/review loops
- Run bridge skills for strategy, PM, testing, design, and GTM workflows
- Keep your plugin evergreen via upstream sync automation

---

## Roadmap

- Improve routing regression corpus breadth
- Expand external clean-machine validation matrix
- Add release-channel strategy (stable/canary)
- Publish optional one-command installer wrapper

---

## FAQ

**Is this a 1:1 clone of ECC/Agency/Claude internals?**  
No. SuperClaw targets **behavioral compatibility** in OpenClaw, not harness byte-parity.

**Will this overload OpenClaw with too many skills?**  
Use `skills-pack-manager.sh` to keep a lean active pack.

**How do I verify it actually works?**  
Run `bash scripts/run-all-tests.sh` and inspect `FULL_TEST_SWEEP_REPORT.md`.

**Can it self-update from upstream repos?**  
Yes — via `sync-all-upstreams.sh` and scheduled GitHub workflow.

---

## Acknowledgements

SuperClaw is built with adapted ideas/patterns from:

1. **Everything Claude Code (ECC)**  
   https://github.com/affaan-m/everything-claude-code
2. **agency-agents**  
   https://github.com/msitarzewski/agency-agents
3. **claude-skills**  
   https://github.com/alirezarezvani/claude-skills
4. **anthropics/skills**  
   https://github.com/anthropics/skills

Traceability files:
- `upstream/NOTICE`
- `upstream/SOURCE_PIN.txt`
- `upstream-import/agency-agents/*`
- `upstream-import/claude-skills/*`
- `upstream-import/anthropic-skills/*`

---

## Contributing

PRs are welcome. Before submitting:

```bash
bash scripts/run-compat-smoke.sh
bash scripts/run-compat-acceptance.sh
bash scripts/run-all-tests.sh
```

Please keep changes OpenClaw-native and avoid reintroducing harness lock-in.

---

## License

See:
- `LICENSE.upstream`
- `upstream/NOTICE`

---

## Start now

```bash
bash scripts/install-wizard.sh
bash scripts/run-compat-smoke.sh
```

If you want, run full confidence mode after that:

```bash
bash scripts/run-all-tests.sh
```
