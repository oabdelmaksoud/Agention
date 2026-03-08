# Full Test Sweep

## Install Wizard Status
- Status: PASS
- Exit: 0
```
📊 Agention status
- Global skills dir: /Users/omarabdelmaksoud/.openclaw/skills (ecc-* count: 148)
- Runtime assets dir: /Users/omarabdelmaksoud/.openclaw/ecc-runtime (present)
- MCP config: /Users/omarabdelmaksoud/.openclaw/workspace/config/mcporter.json (present)
✅ Skill check: ecc-cmd-plan ready
```

## Compat Smoke
- Status: PASS
- Exit: 0
```
Bootstrap checks passed.
HOOK_PARITY_OK
SCHEMA_VALIDATION_OK
ACCEPTANCE: PASS
Validated skills: 95
COMPAT_SMOKE_PASS
```

## Compat Acceptance
- Status: PASS
- Exit: 0
```
COMPAT_ACCEPTANCE_PASS
```

## Core95 Acceptance
- Status: PASS
- Exit: 0
```
ACCEPTANCE: PASS
Validated skills: 95
```

## Bridge Routing Regression
- Status: PASS
- Exit: 0
```
pass=4/4 rate=100.0% verdict=PASS
```

## Agent Scenario Matrix
- Status: PASS
- Exit: 0
```

```

## Hooks Parity Check
- Status: PASS
- Exit: 0
```
HOOK_PARITY_OK
```

## Schema Validation
- Status: PASS
- Exit: 0
```
SCHEMA_VALIDATION_OK
```

## Skill Template Validation
- Status: PASS
- Exit: 0
```

```

## Skill Description Validation
- Status: PASS
- Exit: 0
```

```

## Scenario: Verify Node Sample
- Status: PASS
- Exit: 0
```
VERIFICATION: PASS
Build:    OK
Types:    OK
```

## Scenario: Quality Gate Python Sample
- Status: PASS
- Exit: 0
```
/opt/homebrew/lib/python3.14/site-packages/requests/__init__.py:113: RequestsDependencyWarning: urllib3 (1.26.20) or chardet (6.0.0.post1)/charset_normalizer (3.4.4) doesn't match a supported version!
  warnings.warn(
.                                                                        [100%]
1 passed in 0.00s
QUALITY_GATE_DONE target=/tmp/ecc-burnin/python-app fix=false strict=false
```

## Scenario: Security Scan Repo
- Status: PASS
- Exit: 0
```
SECURITY_SCAN_START target=/Users/omarabdelmaksoud/.openclaw/workspace/openclaw-ecc

  AgentShield Security Report
  2026-03-08T12:27:28.738Z
  Target: /Users/omarabdelmaksoud/.claude

  Grade: F (0/100)

  Score Breakdown
  Secrets        ████████████████████ 100
  Permissions    ░░░░░░░░░░░░░░░░░░░░ 0
  Hooks          ████████████████████ 100
  MCP Servers    ████████████████████ 100
  Agents         ░░░░░░░░░░░░░░░░░░░░ 0

  Summary
  Files scanned: 8
  Findings: 18 total — 4 critical, 8 high, 6 medium, 0 low, 0 info

  Findings

  ● CRITICAL (4)

    ● Dangerous flag: --no-verify
      commands/commit.md:2
      Git hook verification bypass. The flag "--no-verify" disables safety mechanisms.
      Evidence: --no-verify
      Fix: Remove dangerous bypass flag

    ● Dangerous flag: --no-verify
      commands/commit.md:19
      Git hook verification bypass. The flag "--no-verify" disables safety mechanisms.
      Evidence: --no-verify
      Fix: Remove dangerous bypass flag

    ● Dangerous flag: --no-verify
      commands/commit.md:26
      Git hook verification bypass. The flag "--no-verify" disables safety mechanisms.
      Evidence: --no-verify
      Fix: Remove dangerous bypass flag

    ● Dangerous flag: --no-verify
      commands/commit.md:34
      Git hook verification bypass. The flag "--no-verify" disables safety mechanisms.
      Evidence: --no-verify
      Fix: Remove dangerous bypass flag

  ● HIGH (8)

    ● No deny list configured
      settings.json
      settings.json has no deny list. Without explicit denials, the agent may run dangerous operations if the allow list is too broad.
      Fix: Add a deny list for dangerous operations

    ● Encoded payload or decode instruction detected
      agents/bug-analyzer.md:22
      Found "backward to initial problem sources
" — Reversed text instruction — evasion technique to hide commands from pattern matching. Encoding is used to evade pattern-based detection of malicious instructions.
      Evidence: backward to initial problem sources

```

## Scenario: Loop Start/Status/Stop
- Status: PASS
- Exit: 0
```

```

## Scenario: MCP Config List
- Status: PASS
- Exit: 0
```
{
  "servers": [
    {
      "name": "memory",
      "description": "Session memory",
      "source": {
        "kind": "local",
        "path": "/Users/omarabdelmaksoud/.openclaw/workspace/config/mcporter.json"
      },
      "transport": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-memory"
      ],
      "cwd": "/Users/omarabdelmaksoud/.openclaw/workspace/config"
    },
    {
      "name": "github",
      "description": "GitHub ops",
      "source": {
        "kind": "local",
        "path": "/Users/omarabdelmaksoud/.openclaw/workspace/config/mcporter.json"
      },
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
      },
      "transport": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-github"
      ],
      "cwd": "/Users/omarabdelmaksoud/.openclaw/workspace/config"
    },
    {
      "name": "filesystem",
      "description": "Scoped filesystem",
      "source": {
        "kind": "local",
        "path": "/Users/omarabdelmaksoud/.openclaw/workspace/config/mcporter.json"
      },
      "transport": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/workspace"
      ],
      "cwd": "/Users/omarabdelmaksoud/.openclaw/workspace/config"
    }
  ]
}
```

## Summary
- Passed: 15
- Failed: 0
