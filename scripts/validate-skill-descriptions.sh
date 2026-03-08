#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
fail=0

# Scope: bridge skills only for this quality phase
for f in "$ROOT"/skills/ecc-claude-*/SKILL.md "$ROOT"/skills/ecc-agency-*/SKILL.md "$ROOT"/skills/ecc-anthropic-*/SKILL.md; do
  [[ -f "$f" ]] || continue

  desc_line=$(grep -E '^description:' "$f" || true)
  if [[ -z "$desc_line" ]]; then
    echo "Missing description: $f"; fail=1; continue
  fi

  # trigger cue must exist
  echo "$desc_line" | grep -Eiq 'Use when|Use for|Use this' || {
    echo "Weak trigger phrasing: $f"; fail=1;
  }

  # basic quality: length check
  dlen=$(echo "$desc_line" | wc -c | tr -d ' ')
  if [[ "$dlen" -lt 60 ]]; then
    echo "Description too short: $f"; fail=1
  fi

done

exit $fail
