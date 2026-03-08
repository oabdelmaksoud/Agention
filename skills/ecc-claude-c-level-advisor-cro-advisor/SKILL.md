---
name: ecc-claude-c-level-advisor-cro-advisor
description: "Bridge skill for claude-skills 'c-level-advisor/cro-advisor'. Use when requests match this specialized domain; adapt guidance to OpenClaw-native tools and verification."
---

# ecc-claude-c-level-advisor-cro-advisor

Apply the upstream skill intent in OpenClaw-native execution.

## Source
- `Upstream skill snapshot: upstream-import/claude-skills/references/c-level-advisor/cro-advisor`

## Workflow
1. Read upstream `SKILL.md` in the referenced snapshot.
2. Translate harness-specific instructions into OpenClaw tool flow.
3. Execute in small verified steps.
4. Return concise findings, actions, and validation.

## Rules
- Preserve intent; do not copy unsafe runtime assumptions.
- Prefer deterministic checks and explicit evidence.
