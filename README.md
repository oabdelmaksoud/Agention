# SuperClaw 🦞

**Turn OpenClaw into an execution-grade multi-agent system with ECC + Agency patterns.**

SuperClaw is a high-signal compatibility pack that combines:
- **ECC-style operational rigor** (plan → execute → verify → harden)
- **Agency-style domain playbooks** (engineering, testing, strategy, product, marketing, design, support, spatial)
- **OpenClaw-native runtime compatibility** (skills, roles, hooks, MCP profiles, validation suites)

---

## Why people use SuperClaw

Most agent setups fail in one of two ways:
1. Great prompts, weak execution discipline
2. Great architecture, weak domain specialization

SuperClaw gives you both:
- **Execution backbone** from ECC patterns
- **Domain intelligence** from Agency playbooks
- **OpenClaw-native integration** so it actually runs where you need it

---

## What’s inside

### ✅ Core Pack
- **121+ OpenClaw skills** (`ecc-cmd-*`, `ecc-role-*`, `ecc-*`)
- role-specialized workflows (planner, architect, security reviewer, etc.)
- verification/security/quality-gate discipline

### ✅ Runtime Compatibility Layer
- `contexts/` (dev, research, review)
- `hooks/` (intent mapping)
- `mcp-configs/` (mcporter profiles)
- `schemas/` (validation)

### ✅ Agency Bridge Layer
- `ecc-agency-engineering`
- `ecc-agency-testing`
- `ecc-agency-strategy`
- `ecc-agency-project-management`
- `ecc-agency-marketing`
- `ecc-agency-design`
- `ecc-agency-support`
- `ecc-agency-product`
- `ecc-agency-spatial-computing`

---

## 60-second install

```bash
git clone https://github.com/oabdelmaksoud/SuperClaw.git
cd SuperClaw
bash scripts/install-wizard.sh
```

Then in OpenClaw: start a new session (`/new`) to refresh skill discovery.

### Non-interactive install

```bash
NONINTERACTIVE=1 bash scripts/install-wizard.sh --profile standard
```

---

## Install Wizard (enhanced)

```bash
# Interactive
bash scripts/install-wizard.sh

# Dry run
bash scripts/install-wizard.sh --dry-run

# Status check
bash scripts/install-wizard.sh --status

# Strict MCP profile
bash scripts/install-wizard.sh --profile strict

# Uninstall
bash scripts/install-wizard.sh --uninstall
```

---

## Proof it works

Run the compatibility checks:

```bash
bash scripts/run-compat-smoke.sh
bash scripts/run-compat-acceptance.sh
```

Optional deeper checks:

```bash
bash scripts/run-acceptance.sh tests/acceptance/core95.json
bash scripts/run-agent-scenarios.sh AGENT_SCENARIO_MATRIX.md
```

See reports:
- `COMPAT_VALIDATION_REPORT.md`
- `SCENARIO_E2E_VALIDATION.md`
- `HOOKS_AGENTS_TEST_REPORT.md`
- `SUBAGENT_DELEGATION_TEST_REPORT.md`

---

## Compatibility model (important)

SuperClaw targets **behavioral compatibility**, not harness-by-harness byte cloning.

- ECC commands → OpenClaw command skills
- ECC agents → OpenClaw role skills
- ECC rules/hooks/MCP intent → OpenClaw-native runtime layers
- Harness-specific internals are selectively adapted/archived

Read:
- `COMPATIBILITY.md`
- `COMPATIBILITY_CLOSURE_MATRIX.md`
- `HARNESS_TRANSLATION_MATRIX.md`

---

## Acknowledgements

SuperClaw is built on adapted patterns from:
- **Everything Claude Code** — <https://github.com/affaan-m/everything-claude-code>
- **agency-agents** — <https://github.com/msitarzewski/agency-agents>

Traceability:
- `upstream/NOTICE`
- `upstream/SOURCE_PIN.txt`
- `upstream-import/agency-agents/SOURCE_PIN.txt`
- `upstream-import/agency-agents/NOTICE.md`

---

## For contributors

Before opening a PR:

```bash
bash scripts/run-compat-smoke.sh
bash scripts/run-compat-acceptance.sh
```

Keep changes OpenClaw-native and avoid introducing harness lock-in.

---

## License

See:
- `LICENSE.upstream`
- `upstream/NOTICE`
