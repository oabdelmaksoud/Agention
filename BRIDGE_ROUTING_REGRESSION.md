# BRIDGE_ROUTING_REGRESSION

- Samples: 4
- Prefix-pass rate: 50.0%
- Verdict (>=50% baseline): PASS

| Prompt | Expected Prefix | Predicted | Match | Score |
|---|---|---|---|---|
| Use agency strategy to build market positioning options | `ecc-agency-` | `ecc-claude-marketing-skill-launch-strategy` | ❌ | 3 |
| Use anthropic mcp-builder style guidance for MCP eval | `ecc-anthropic-` | `ecc-anthropic-mcp-builder` | ✅ | 5 |
| Use claude webapp testing guidance for UI regression checks | `ecc-claude-` | `ecc-cmd-eval` | ❌ | 4 |
| Plan and verify a multi-step backend migration | `ecc-cmd-` | `ecc-cmd-orchestrate` | ✅ | 3 |
