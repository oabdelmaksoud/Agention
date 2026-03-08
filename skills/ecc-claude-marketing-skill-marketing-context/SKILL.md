---
name: ecc-claude-marketing-skill-marketing-context
description: "Bridge skill for claude-skills 'marketing-skill/marketing-context'. Use when requests match this specialized domain; adapt guidance to OpenClaw-native tools and verification."
---

# ecc-claude-marketing-skill-marketing-context

Apply the upstream skill intent in OpenClaw-native execution.

## Source
- `Upstream skill snapshot: upstream-import/claude-skills/references/marketing-skill/marketing-context`

## Workflow
1. Read upstream `SKILL.md` in the referenced snapshot.
2. Translate harness-specific instructions into OpenClaw tool flow.
3. Execute in small verified steps.
4. Return concise findings, actions, and validation.

## Rules
- Preserve intent; do not copy unsafe runtime assumptions.
- Prefer deterministic checks and explicit evidence.
