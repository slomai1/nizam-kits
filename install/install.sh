#!/usr/bin/env bash
set -euo pipefail

CLAUDE_DIR="${CLAUDE_DIR:-$HOME/.claude}"
FORCE=0
MINIMAL=0
SKIP_CLAUDE_CHECK=0

usage() {
  cat <<'EOF'
Usage: ./install.sh [OPTIONS]

Installs nizam-deepseek into ~/.claude (or $CLAUDE_DIR).

Options:
  --force              Replace existing files instead of skipping
  --minimal            Install core only (no extra plugins/marketplaces)
  --skip-claude-check  Skip Claude Code installation check
  --help               Show this help
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force) FORCE=1; shift ;;
    --minimal) MINIMAL=1; shift ;;
    --skip-claude-check) SKIP_CLAUDE_CHECK=1; shift ;;
    --help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ "$SKIP_CLAUDE_CHECK" -eq 0 ]]; then
  if ! command -v claude >/dev/null 2>&1; then
    echo "Claude Code not found. Install it first or use --skip-claude-check" >&2
    exit 1
  fi
fi

mkdir -p "$CLAUDE_DIR"

ADDED=0
SKIPPED=0

copy_file() {
  local from="$1" to="$2"
  if [[ -f "$to" && "$FORCE" -eq 0 ]]; then
    echo "skip $to"
    ((SKIPPED++))
  else
    mkdir -p "$(dirname "$to")"
    cp "$from" "$to"
    echo "add $to"
    ((ADDED++))
  fi
}

copy_dir() {
  local from="$1" to="$2"
  mkdir -p "$to"
  cp -R "$from/." "$to"
  echo "added $to/"
  ((ADDED++))
}

ROOT="$(cd "$(dirname "$0")" && pwd)"

copy_file "$ROOT/core/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
copy_file "$ROOT/core/hooks/block_dangerous.sh" "$CLAUDE_DIR/hooks/block_dangerous.sh"
copy_file "$ROOT/core/hooks/block_secrets.sh" "$CLAUDE_DIR/hooks/block_secrets.sh"
copy_file "$ROOT/core/hooks/verify_paths.sh" "$CLAUDE_DIR/hooks/verify_paths.sh"
copy_file "$ROOT/core/hooks/loop_prevention.sh" "$CLAUDE_DIR/hooks/loop_prevention.sh"
copy_file "$ROOT/core/hooks/auto_format.sh" "$CLAUDE_DIR/hooks/auto_format.sh"
copy_file "$ROOT/core/rules/operating-system-policy.md" "$CLAUDE_DIR/rules/operating-system-policy.md"
copy_file "$ROOT/core/rules/golden-set.md" "$CLAUDE_DIR/rules/golden-set.md"

for cmd in "$ROOT/core/commands/"*.md; do
  [[ -f "$cmd" ]] || continue
  copy_file "$cmd" "$CLAUDE_DIR/commands/$(basename "$cmd")"
done

for skill in "$ROOT/core/skills/"*/; do
  [[ -d "$skill" ]] || continue
  copy_dir "$skill" "$CLAUDE_DIR/skills/$(basename "$skill")"
done

for wf in "$ROOT/core/workflows/"*.js; do
  [[ -f "$wf" ]] || continue
  copy_file "$wf" "$CLAUDE_DIR/workflows/$(basename "$wf")"
done

if [[ "$MINIMAL" -eq 0 ]]; then
  if [[ -f "$ROOT/templates/settings.template.json" ]]; then
    copy_file "$ROOT/templates/settings.template.json" "$CLAUDE_DIR/settings.json"
  fi
fi

for js in "$ROOT/install/"*.js; do
  [[ -f "$js" ]] || continue
  copy_file "$js" "$CLAUDE_DIR/scripts/$(basename "$js")"
done

echo "Done. Added: $ADDED, Skipped: $SKIPPED"
