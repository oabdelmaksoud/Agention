# AGENCY_AGENTS_INTEGRATION_PLAN

## Goal
Integrate high-value portable patterns from agency-agents into SuperClaw/OpenClaw-native skills.

## Source
- Repo: https://github.com/msitarzewski/agency-agents
- Commit: 5e32f1d1ac206dde20120af1c4fb667244824b31
- License: MIT

## Inventory Snapshot
- Total files: 91
- Markdown files: 84

| Top Area | Markdown Files | Integration Direction |
|---|---:|---|
| `.github` | 1 | assess and map to existing/new skill family |
| `CONTRIBUTING.md` | 1 | reference only |
| `README.md` | 1 | reference only |
| `design` | 7 | map to frontend/design/slide skills |
| `engineering` | 8 | map to existing engineering role/command skills first |
| `examples` | 4 | assess and map to existing/new skill family |
| `marketing` | 11 | map to content/article/outreach skills |
| `product` | 3 | likely new product skill family |
| `project-management` | 5 | map to chief-of-staff/checkpoint/orchestrate |
| `spatial-computing` | 6 | likely new spatial-computing skill family |
| `specialized` | 7 | case-by-case mapping |
| `strategy` | 16 | map to strategic/market/investor skills |
| `support` | 6 | likely new support skill family |
| `testing` | 8 | map to verify/quality-gate/e2e/test-coverage skills |

## Execution Phases

1. **Audit & map** each area to existing SuperClaw skills (or mark as new skill needed).
2. **Import references** into `upstream-import/agency-agents/references/` by area.
3. **Create new skill families** only for gaps (support/product/spatial-computing).
4. **Add scenario tests** for any newly added skills.
5. **Run compat smoke + acceptance** and update reports.

## Immediate Next Step
Generate a detailed per-file mapping matrix (`AGENCY_AGENTS_MAPPING_MATRIX.md`) and start with `engineering/` + `testing/` as highest ROI.
