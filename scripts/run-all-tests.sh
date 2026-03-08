#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
REPORT="$ROOT/FULL_TEST_SWEEP_REPORT.md"
: > "$REPORT"

pass=0
fail=0
run(){
  name="$1"; shift
  echo "## $name" >> "$REPORT"
  set +e
  out="$($@ 2>&1)"
  code=$?
  set -e
  if [[ $code -eq 0 ]]; then st="PASS"; pass=$((pass+1)); else st="FAIL"; fail=$((fail+1)); fi
  echo "- Status: $st" >> "$REPORT"
  echo "- Exit: $code" >> "$REPORT"
  echo '```' >> "$REPORT"
  echo "$out" | sed -n '1,60p' >> "$REPORT"
  echo '```' >> "$REPORT"
  echo >> "$REPORT"
}

echo "# Full Test Sweep" >> "$REPORT"
echo >> "$REPORT"

run "Install Wizard Status" bash "$ROOT/scripts/install-wizard.sh" --status
run "Compat Smoke" bash "$ROOT/scripts/run-compat-smoke.sh"
run "Compat Acceptance" bash "$ROOT/scripts/run-compat-acceptance.sh"
run "Core95 Acceptance" bash "$ROOT/scripts/run-acceptance.sh" "$ROOT/tests/acceptance/core95.json"
run "Bridge Routing Regression" python3 "$ROOT/scripts/eval-bridge-routing.py"
run "Agent Scenario Matrix" bash "$ROOT/scripts/run-agent-scenarios.sh" "$ROOT/AGENT_SCENARIO_MATRIX.md"
run "Hooks Parity Check" bash "$ROOT/scripts/hook-parity-check.sh"
run "Schema Validation" bash "$ROOT/scripts/validate-schemas.sh"
run "Skill Template Validation" bash "$ROOT/scripts/validate-skill-template.sh"
run "Skill Description Validation" bash "$ROOT/scripts/validate-skill-descriptions.sh"

# multi-scenario functional checks against sample repos
run "Scenario: Verify Node Sample" bash "$ROOT/scripts/run-verify.sh" quick /tmp/ecc-burnin/node-app
run "Scenario: Quality Gate Python Sample" bash "$ROOT/scripts/run-quality-gate.sh" /tmp/ecc-burnin/python-app
run "Scenario: Security Scan Repo" bash "$ROOT/scripts/run-security-scan.sh" "$ROOT"
run "Scenario: Loop Start/Status/Stop" bash -lc "bash '$ROOT/scripts/loopctl.sh' start 'full-test' 2 && bash '$ROOT/scripts/loopctl.sh' status && bash '$ROOT/scripts/loopctl.sh' stop"
run "Scenario: MCP Config List" mcporter --config ~/.openclaw/workspace/config/mcporter.json config list --json

echo "## Summary" >> "$REPORT"
echo "- Passed: $pass" >> "$REPORT"
echo "- Failed: $fail" >> "$REPORT"

if [[ $fail -eq 0 ]]; then
  echo "FULL_TEST_SWEEP: PASS"
else
  echo "FULL_TEST_SWEEP: FAIL ($fail failures)"
fi
