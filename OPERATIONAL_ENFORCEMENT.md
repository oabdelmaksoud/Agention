# OPERATIONAL_ENFORCEMENT

This file defines mandatory execution behavior for Agention operations.

## 1) Subagent Trigger Rule (MANDATORY)

Use subagents when any condition is true:
- task is multi-step and non-trivial
- task spans multiple domains (e.g., code + security + docs)
- independent tracks can run in parallel
- verification/review should be separated from implementation

## 2) Delegation Reporting (MANDATORY when delegation used)

Include a compact block in the final response:
- Subagents spawned
- Scope assigned per subagent
- Result per subagent
- Merge decision/final outcome

## 3) Change Reporting (MANDATORY when changes happened)

Only when actual changes occurred, include:
- files changed
- commit hash(es)
- what was changed

Do NOT include a change block when no changes occurred.

## 4) Pre-send Self-check (MANDATORY)

Before sending a task response:
1. If complexity required delegation, confirm subagents were used.
2. If changes happened, confirm change summary is included.
3. If any rule was missed, correct before sending.

## 5) Miss Recovery

If a rule is missed:
- immediately rerun or append corrected details in the next reply
- do not leave the workflow in partial state
