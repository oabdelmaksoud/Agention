---
name: ecc-claude-engineering-monorepo-navigator
description: "Bridge skill for claude-skills 'engineering/monorepo-navigator'. Use when requests match this specialized domain; adapt guidance to OpenClaw-native tools and verification."
---

# ecc-claude-engineering-monorepo-navigator

Apply the upstream skill intent in OpenClaw-native execution.

## Source
- `Upstream skill snapshot: upstream-import/claude-skills/references/engineering/monorepo-navigator`

## Workflow
1. Read upstream `SKILL.md` in the referenced snapshot.
2. Translate harness-specific instructions into OpenClaw tool flow.
3. Execute in small verified steps.
4. Return concise findings, actions, and validation.

## Rules
- Preserve intent; do not copy unsafe runtime assumptions.
- Prefer deterministic checks and explicit evidence.
