# Agention ⚡ ⚡
[<img src="assets/logo.svg" width="48" height="48">](https://github.com/oabdelmaksoud/Agention)
 for OpenClaw

> **Portable execution intelligence for OpenClaw**  
> Agention brings ECC-style operational patterns, skill orchestration, compatibility tooling, and upstream sync discipline into a practical, installable OpenClaw package.

[![Compatibility](https://img.shields.io/badge/OpenClaw-Compatible-2ea44f)](#compatibility--scope)
[![Skills](https://img.shields.io/badge/Skill%20Pack-ecc--*-0366d6)](#skill-packs-core-vs-full)
[![Validation](https://img.shields.io/badge/Validation-Built--in-orange)](#validation-suite)

---

## Why Agention

Agention is a curated OpenClaw-native distribution designed for teams that want **repeatable agent behavior** with **real operational guardrails**.

### Key benefits

- **OpenClaw-native execution** — no fragile harness emulation; behavior is adapted to OpenClaw surfaces.
- **Large skill inventory** — command/domain/bridge/agency-oriented `ecc-*` skill set in `skills/`.
- **Install + operate + verify lifecycle** — wizard installer, runtime integration, compatibility checks, quality/security/eval scripts.
- **Upstream traceability baked in** — source pins, notices, and sync metadata under `upstream*`.
- **Delegation policy included** — explicit subagent and reporting rules in `SUBAGENT_POLICY.md` and `OPERATIONAL_ENFORCEMENT.md`.

---

## Architecture (ASCII)

```text
                          ┌──────────────────────────────┐
                          │        Upstream Sources       │
                          │  ECC / agency / claude / anth │
                          └──────────────┬───────────────┘
                                         │ sync/update
                                         ▼
┌────────────────────────────────────────────────────────────────────┐
│                         openclaw-ecc repo                         │
│                                                                    │
│  skills/         contexts/ hooks/ mcp-configs/ schemas/ tests/     │
│     │                 │         │          │          │             │
│     └──────┬──────────┴─────────┴─────┬────┴──────────┘             │
│            │                          scripts/                        │
│            │         install / validate / eval / sync / pack-manage  │
└────────────┼───────────────────────────────┬──────────────────────────┘
             │                               │
             │ install-wizard.sh             │ sync-all-upstreams.sh
             ▼                               ▼
   ~/.openclaw/skills                  upstream-sync/work
   ~/.openclaw/ecc-runtime             SYNC_CHANGELOG.md
   ~/.openclaw/workspace/config/       SOURCE_PIN updates
      mcporter.json
             │
             ▼
      OpenClaw runtime
      (new session / skill discovery)
```

---

## Feature matrix

| Area | What you get | Primary scripts/files |
|---|---|---|
| Install orchestration | Guided, non-interactive, status, uninstall flows | `scripts/install-wizard.sh`, `INSTALL.md` |
| Runtime integration | Context/hook/MCP/schema asset sync into `~/.openclaw/ecc-runtime` | `scripts/integrate-openclaw-runtime.sh` |
| MCP profile application | Minimal/standard/strict profile apply | `scripts/apply-mcporter-profile.sh` |
| Skill pack tiering | Core vs full `ecc-*` pack switching | `scripts/skills-pack-manager.sh` |
| Compatibility testing | Smoke + acceptance compatibility runs | `scripts/run-compat-smoke.sh`, `scripts/run-compat-acceptance.sh` |
| Quality/Security/Eval | Verification, quality gate, security scan, eval | `scripts/run-verify.sh`, `scripts/run-quality-gate.sh`, `scripts/run-security-scan.sh`, `scripts/run-eval.sh` |
| Schema/skill validation | Skill template/description/schema validators | `scripts/validate-schemas.sh`, `scripts/validate-skill-template.sh`, `scripts/validate-skill-descriptions.sh`, `scripts/validate-skills.sh` |
| Full sweep regression | Consolidated report across major checks | `scripts/run-all-tests.sh`, `FULL_TEST_SWEEP_REPORT.md` |
| Upstream sync pipeline | Multi-source sync + pin updates + post-sync validation | `scripts/sync-all-upstreams.sh`, `UPSTREAM_SOURCES.json`, `SYNC_CHANGELOG.md` |
| Operational policy | Delegation and response enforcement rules | `SUBAGENT_POLICY.md`, `OPERATIONAL_ENFORCEMENT.md` |

---

## Quickstart

```bash
cd openclaw-ecc
bash scripts/install-wizard.sh
```

After install:

```bash
# start fresh session so OpenClaw re-indexes skills
# /new

openclaw skills info ecc-cmd-plan
bash scripts/run-compat-smoke.sh
```

If smoke passes, you’re ready for normal Agention usage.

---

## Install Wizard (advanced usage)

The install wizard is the recommended operator entrypoint.

### Common modes

```bash
# Non-interactive defaults
NONINTERACTIVE=1 bash scripts/install-wizard.sh

# Explicit profile
bash scripts/install-wizard.sh --profile strict

# Dry run
bash scripts/install-wizard.sh --dry-run

# Skip selected phases
bash scripts/install-wizard.sh --skip-runtime --skip-mcp

# Status summary
bash scripts/install-wizard.sh --status

# Uninstall Agention-managed assets
bash scripts/install-wizard.sh --uninstall
```

### MCP profile options

- `minimal`
- `standard` (default)
- `strict`

### Install targets used by wizard

- Skills: `~/.openclaw/skills`
- Runtime bundle: `~/.openclaw/ecc-runtime`
- MCP config: `~/.openclaw/workspace/config/mcporter.json`

---

## Validation suite

### Fast checks

```bash
bash scripts/run-compat-smoke.sh
bash scripts/run-compat-acceptance.sh
```

### Deep validation

```bash
bash scripts/run-verify.sh
bash scripts/run-quality-gate.sh
bash scripts/run-security-scan.sh
bash scripts/run-eval.sh
```

### Structural validators

```bash
bash scripts/validate-skills.sh
bash scripts/validate-skill-template.sh
bash scripts/validate-skill-descriptions.sh
bash scripts/validate-schemas.sh
```

### Full sweep (single command)

```bash
bash scripts/run-all-tests.sh
# output: FULL_TEST_SWEEP_REPORT.md
```

---

## Skill packs: Core vs Full

Agention supports operational tiering via `scripts/skills-pack-manager.sh`.

### Core pack (`apply-core`)

- Keeps OpenClaw-compatible essentials active.
- Parks heavier Claude bridge skills matching `ecc-claude-*` into `~/.openclaw/skills-parked`.
- Useful for leaner runtime footprint and tighter focus.

### Full pack (`apply-full`)

- Restores parked `ecc-*` skills from `~/.openclaw/skills-parked` back to active skills.
- Useful when you want maximum capability and bridge coverage.

### Commands

```bash
bash scripts/skills-pack-manager.sh status
bash scripts/skills-pack-manager.sh apply-core
bash scripts/skills-pack-manager.sh apply-full
```

---

## Auto-sync pipeline

Agention includes a multi-source sync pipeline configured by `UPSTREAM_SOURCES.json`:

- `everything-claude-code`
- `agency-agents`
- `claude-skills`
- `anthropics/skills`

### Run sync

```bash
bash scripts/sync-all-upstreams.sh
```

### What it does

1. Clones/fetches each configured source into `upstream-sync/work/<id>`.
2. Resolves latest HEAD for configured branch.
3. Compares against recorded `commit:` in each source pin file.
4. Updates pin files when changes are detected.
5. Writes `SYNC_CHANGELOG.md` summary.
6. Executes post-sync validation chain:
   - `validate-skills.sh`
   - `validate-skill-template.sh`
   - `validate-skill-descriptions.sh`
   - `run-compat-acceptance.sh`

For ECC-only sync metadata, see `scripts/sync-upstream.sh` and `upstream/SYNC_REPORT.json`.

---

## Subagent policy

Agention’s default operating stance is **proactive delegation for medium/high complexity tasks**.

Policy sources:

- `SUBAGENT_POLICY.md`
- `OPERATIONAL_ENFORCEMENT.md`

Highlights:

- Delegate when work is multi-step, multi-domain, parallelizable, or requires independent verification.
- When delegation is used, final reporting should include:
  - subagents spawned
  - assigned scope
  - per-subagent result
  - merge/final decision
- If changes occurred, include file/commit change reporting.

---

## Compatibility & scope

Agention targets **behavioral compatibility** with ECC-style patterns while preserving OpenClaw-native execution semantics.

Reference docs:

- `COMPATIBILITY.md`
- `COMPATIBILITY_CLOSURE_MATRIX.md`
- `HARNESS_TRANSLATION_MATRIX.md`
- `MIGRATION_MATRIX.md`

---

## Roadmap

Planned/active directions based on current repo artifacts:

- Continue closure and regression hardening (`COMPATIBILITY_CLOSURE_MATRIX.md`, `BRIDGE_ROUTING_REGRESSION.md`).
- Expand scenario and end-to-end coverage (`AGENT_SCENARIO_MATRIX.md`, `SCENARIO_E2E_VALIDATION.md`).
- Maintain quality contract enforcement (`SKILL_QUALITY_CONTRACT.md`, pass reports).
- Iterate release quality milestones (`RELEASE_NOTES_v0.4.0-quality.md`, `RELEASE_READY.md`).
- Ongoing upstream sync and attribution integrity (`SYNC_CHANGELOG.md`, `UPSTREAM_SOURCES.json`).

---

## FAQ

### Is Agention a drop-in clone of ECC?
No. It is an OpenClaw-native compatibility and operations layer inspired by ECC and related upstream ecosystems.

### Do I need `mcporter`?
Only if you want MCP profile automation (`scripts/apply-mcporter-profile.sh`, wizard MCP phase).

### Why don’t I see new skills immediately after install?
Start a fresh OpenClaw session (`/new`) so skills are rediscovered.

### How do I verify installation health quickly?
Use:

```bash
openclaw skills info ecc-cmd-plan
bash scripts/run-compat-smoke.sh
```

### How do I reduce skill load for lighter operation?
Use core mode:

```bash
bash scripts/skills-pack-manager.sh apply-core
```

### How do I restore full capability?

```bash
bash scripts/skills-pack-manager.sh apply-full
```

---

## Acknowledgements

Agention adapts and builds on ideas and/or source artifacts from:

1. **Everything Claude Code (ECC)** — <https://github.com/affaan-m/everything-claude-code>
2. **agency-agents** — <https://github.com/msitarzewski/agency-agents>
3. **claude-skills** — <https://github.com/alirezarezvani/claude-skills>
4. **anthropics/skills** — <https://github.com/anthropics/skills>

Traceability lives in `upstream/`, `upstream-import/`, and `UPSTREAM_SOURCES.json`.

---

## Contributing

Contributions are welcome, especially in:

- compatibility closure and mapping accuracy
- test/validation improvements
- docs and install/operator UX
- upstream sync reliability

Suggested contribution flow:

1. Fork and create a focused branch.
2. Make changes with clear scope and rationale.
3. Run relevant validators (at minimum smoke + structural checks):
   ```bash
   bash scripts/run-compat-smoke.sh
   bash scripts/validate-skills.sh
   bash scripts/validate-skill-template.sh
   bash scripts/validate-skill-descriptions.sh
   ```
4. Include/report any compatibility impact.
5. Open a PR with concise before/after behavior notes.

---

## License note

This repository includes mixed-origin compatibility assets and upstream-derived materials.

- Review `LICENSE.upstream` and all `NOTICE`/`SOURCE_PIN` files before redistribution.
- Respect licenses and attribution obligations for each upstream source.
- Preserve provenance metadata when syncing or porting additional content.

---

## Start here

```bash
bash scripts/install-wizard.sh
bash scripts/run-compat-smoke.sh
```

If both complete cleanly, Agention is ready for production-style OpenClaw workflows.
