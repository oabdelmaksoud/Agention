#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_SRC="$ROOT/skills"
GLOBAL_SKILLS_DIR="$HOME/.openclaw/skills"
RUNTIME_TARGET="$HOME/.openclaw/ecc-runtime"
MCP_CONFIG="$HOME/.openclaw/workspace/config/mcporter.json"

NONINTERACTIVE="${NONINTERACTIVE:-0}"
PROFILE="${PROFILE:-standard}"
DO_SKILLS=1
DO_RUNTIME=1
DO_MCP=1
DO_VALIDATE=1
DRY_RUN=0
MODE="install"

say(){ printf "%s\n" "$*"; }
warn(){ printf "⚠️ %s\n" "$*"; }
ok(){ printf "✅ %s\n" "$*"; }

usage(){
  cat <<EOF
SuperClaw Install Wizard

Usage:
  bash scripts/install-wizard.sh [options]

Options:
  --non-interactive           No prompts; use defaults/flags
  --profile <name>            MCP profile: minimal|standard|strict (default: standard)
  --skip-skills               Do not install skills
  --skip-runtime              Do not sync runtime assets
  --skip-mcp                  Do not apply MCP profile
  --skip-validate             Do not run validation checks
  --dry-run                   Print actions without applying changes
  --status                    Print install/status summary and exit
  --uninstall                 Remove installed SuperClaw assets (skills + runtime + MCP config)
  -h, --help                  Show this help

Environment:
  NONINTERACTIVE=1            Equivalent to --non-interactive
EOF
}

ask(){
  local prompt="$1" default="${2:-y}" ans
  if [[ "$NONINTERACTIVE" == "1" ]]; then
    ans="$default"
  else
    read -r -p "$prompt [y/n] (default: $default): " ans || true
    ans="${ans:-$default}"
  fi
  [[ "$ans" =~ ^[Yy]$ ]]
}

run(){
  if [[ "$DRY_RUN" == "1" ]]; then
    say "[dry-run] $*"
  else
    eval "$@"
  fi
}

status(){
  say "📊 SuperClaw status"
  local skill_count=0
  if [[ -d "$GLOBAL_SKILLS_DIR" ]]; then
    skill_count=$(find "$GLOBAL_SKILLS_DIR" -maxdepth 1 -mindepth 1 -type d -name 'ecc-*' | wc -l | tr -d ' ')
  fi
  say "- Global skills dir: $GLOBAL_SKILLS_DIR (ecc-* count: $skill_count)"
  say "- Runtime assets dir: $RUNTIME_TARGET ($( [[ -d "$RUNTIME_TARGET" ]] && echo present || echo missing ))"
  say "- MCP config: $MCP_CONFIG ($( [[ -f "$MCP_CONFIG" ]] && echo present || echo missing ))"
  if command -v openclaw >/dev/null 2>&1; then
    if openclaw skills info ecc-cmd-plan >/dev/null 2>&1; then ok "Skill check: ecc-cmd-plan ready"; else warn "Skill check failed"; fi
  fi
}

uninstall(){
  say "🧹 SuperClaw uninstall"
  if [[ -d "$GLOBAL_SKILLS_DIR" ]]; then
    run "find '$GLOBAL_SKILLS_DIR' -maxdepth 1 -mindepth 1 -type d -name 'ecc-*' -exec rm -rf {} +"
    ok "Removed ecc-* skills from $GLOBAL_SKILLS_DIR"
  fi
  if [[ -d "$RUNTIME_TARGET" ]]; then
    run "rm -rf '$RUNTIME_TARGET'"
    ok "Removed runtime assets at $RUNTIME_TARGET"
  fi
  if [[ -f "$MCP_CONFIG" ]]; then
    run "rm -f '$MCP_CONFIG'"
    ok "Removed MCP config at $MCP_CONFIG"
  fi
  say "Done."
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --non-interactive) NONINTERACTIVE=1 ;;
    --profile) PROFILE="${2:-}"; shift ;;
    --skip-skills) DO_SKILLS=0 ;;
    --skip-runtime) DO_RUNTIME=0 ;;
    --skip-mcp) DO_MCP=0 ;;
    --skip-validate) DO_VALIDATE=0 ;;
    --dry-run) DRY_RUN=1 ;;
    --status) MODE="status" ;;
    --uninstall) MODE="uninstall" ;;
    -h|--help) usage; exit 0 ;;
    *) warn "Unknown arg: $1"; usage; exit 1 ;;
  esac
  shift
done

if [[ "$MODE" == "status" ]]; then
  status
  exit 0
fi
if [[ "$MODE" == "uninstall" ]]; then
  uninstall
  exit 0
fi

say "🧩 SuperClaw Install Wizard"
say "Source: $ROOT"

if [[ ! -d "$SKILLS_SRC" ]]; then
  say "❌ skills/ directory not found at $SKILLS_SRC"
  exit 1
fi

if [[ "$PROFILE" != "minimal" && "$PROFILE" != "standard" && "$PROFILE" != "strict" ]]; then
  say "❌ Invalid profile '$PROFILE' (use minimal|standard|strict)"
  exit 1
fi

if [[ "$DO_SKILLS" == "1" ]]; then
  if [[ "$NONINTERACTIVE" == "1" ]] || ask "Install SuperClaw skills globally for all workspaces?" y; then
    run "mkdir -p '$GLOBAL_SKILLS_DIR'"
    run "rsync -a --delete '$SKILLS_SRC/' '$GLOBAL_SKILLS_DIR/'"
    if [[ "$DRY_RUN" == "0" ]]; then
      count=$(find "$GLOBAL_SKILLS_DIR" -maxdepth 1 -mindepth 1 -type d -name 'ecc-*' | wc -l | tr -d ' ')
      ok "Installed $count ECC skills to $GLOBAL_SKILLS_DIR"
    fi
  else
    say "⏭ Skipped global skills install"
  fi
fi

if [[ "$DO_RUNTIME" == "1" ]]; then
  if [[ "$NONINTERACTIVE" == "1" ]] || ask "Install runtime assets (contexts/hooks/mcp-configs/schemas)?" y; then
    run "mkdir -p '$RUNTIME_TARGET'"
    run "rsync -a --delete '$ROOT/contexts/' '$RUNTIME_TARGET/contexts/'"
    run "rsync -a --delete '$ROOT/hooks/' '$RUNTIME_TARGET/hooks/'"
    run "rsync -a --delete '$ROOT/mcp-configs/' '$RUNTIME_TARGET/mcp-configs/'"
    run "rsync -a --delete '$ROOT/schemas/' '$RUNTIME_TARGET/schemas/'"
    ok "Runtime assets synced to $RUNTIME_TARGET"
  else
    say "⏭ Skipped runtime assets"
  fi
fi

if [[ "$DO_MCP" == "1" ]]; then
  if command -v mcporter >/dev/null 2>&1; then
    if [[ "$NONINTERACTIVE" == "1" ]] || ask "Apply mcporter MCP profile now?" y; then
      run "bash '$ROOT/scripts/apply-mcporter-profile.sh' '$PROFILE'"
      ok "MCP profile '$PROFILE' applied"
    else
      say "⏭ Skipped MCP profile apply"
    fi
  else
    warn "mcporter not found. Install with: npm i -g mcporter"
  fi
fi

if [[ "$DO_VALIDATE" == "1" ]]; then
  say "\n🔎 Quick validation"
  if command -v openclaw >/dev/null 2>&1; then
    if [[ "$DRY_RUN" == "0" ]] && openclaw skills info ecc-cmd-plan >/dev/null 2>&1; then
      ok "Skill check: ecc-cmd-plan ready"
    else
      warn "Skill check failed (try /new then retry)"
    fi
  else
    warn "openclaw CLI not found in PATH"
  fi
  if [[ "$DRY_RUN" == "0" ]]; then
    if bash "$ROOT/scripts/run-compat-smoke.sh" >/dev/null 2>&1; then ok "Compat smoke passed"; else warn "Compat smoke had warnings/failures"; fi
  else
    say "[dry-run] bash '$ROOT/scripts/run-compat-smoke.sh'"
  fi
fi

say "\n🎉 Wizard complete"
say "Next: start a new OpenClaw session (/new) to refresh skill list."
