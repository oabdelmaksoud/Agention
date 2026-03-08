#!/usr/bin/env bash
set -euo pipefail

SRC_SKILLS="${SRC_SKILLS:-$HOME/.openclaw/skills}"
ACTIVE="$HOME/.openclaw/skills"
PARKED="$HOME/.openclaw/skills-parked"

usage(){
  cat <<USAGE
Usage: bash scripts/skills-pack-manager.sh <command>

Commands:
  apply-core    Keep core OpenClaw-compatible set active, park heavy claude bridge set
  apply-full    Restore all parked skills back into active set
  status        Show counts for active/parked sets
USAGE
}

status(){
  a=0; p=0
  [[ -d "$ACTIVE" ]] && a=$(find "$ACTIVE" -maxdepth 1 -mindepth 1 -type d -name 'ecc-*' | wc -l | tr -d ' ')
  [[ -d "$PARKED" ]] && p=$(find "$PARKED" -maxdepth 1 -mindepth 1 -type d -name 'ecc-*' | wc -l | tr -d ' ')
  echo "active=$a parked=$p"
}

apply_core(){
  mkdir -p "$ACTIVE" "$PARKED"
  shopt -s nullglob
  moved=0
  for d in "$ACTIVE"/ecc-claude-*; do
    [[ -d "$d" ]] || continue
    mv "$d" "$PARKED/"
    moved=$((moved+1))
  done
  echo "apply-core moved=$moved"
  status
}

apply_full(){
  mkdir -p "$ACTIVE" "$PARKED"
  shopt -s nullglob
  moved=0
  for d in "$PARKED"/ecc-*; do
    [[ -d "$d" ]] || continue
    mv "$d" "$ACTIVE/"
    moved=$((moved+1))
  done
  echo "apply-full moved=$moved"
  status
}

cmd="${1:-}"
case "$cmd" in
  apply-core) apply_core ;;
  apply-full) apply_full ;;
  status) status ;;
  *) usage; exit 1 ;;
esac
