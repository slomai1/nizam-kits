#!/usr/bin/env bash
set -euo pipefail

SRC_REPO="https://github.com/slomai1/nizam-deepseek.git"
DEST="${HOME}/.claude"
PACKS=""
LIST_ONLY=0
SRC_DIR="${NIZAM_SRC:-}"

usage() {
  cat <<'EOF'
Usage: ./scripts/pick.sh --packs core,arabic [--dest ~/.claude]
       ./scripts/pick.sh --list

Environment:
  NIZAM_SRC   path to a local nizam-deepseek checkout
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --packs) PACKS="${2:-}"; shift 2 ;;
    --dest) DEST="${2:-}"; shift 2 ;;
    --src) SRC_DIR="${2:-}"; shift 2 ;;
    --list) LIST_ONLY=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
done

copy_file() {
  local from="$1" to="$2"
  mkdir -p "$(dirname "$to")"
  cp "$from" "$to"
  echo "  $from -> $to"
}

copy_dir() {
  local from="$1" to="$2"
  mkdir -p "$to"
  cp -R "$from/." "$to"
  echo "  $from/ -> $to/"
}

install_core() {
  copy_file "$SRC_DIR/core/CLAUDE.md" "$DEST/CLAUDE.md"
  copy_file "$SRC_DIR/core/hooks/block_dangerous.sh" "$DEST/hooks/block_dangerous.sh"
  copy_file "$SRC_DIR/core/hooks/block_secrets.sh" "$DEST/hooks/block_secrets.sh"
  copy_file "$SRC_DIR/core/hooks/verify_paths.sh" "$DEST/hooks/verify_paths.sh"
  copy_file "$SRC_DIR/core/hooks/loop_prevention.sh" "$DEST/hooks/loop_prevention.sh"
  copy_file "$SRC_DIR/core/hooks/auto_format.sh" "$DEST/hooks/auto_format.sh"
  copy_file "$SRC_DIR/core/rules/operating-system-policy.md" "$DEST/rules/operating-system-policy.md"
  copy_file "$SRC_DIR/core/rules/golden-set.md" "$DEST/rules/golden-set.md"
}

install_arabic() {
  copy_file "$SRC_DIR/core/commands/explain-ar.md" "$DEST/commands/explain-ar.md"
  copy_file "$SRC_DIR/core/commands/review-ar.md" "$DEST/commands/review-ar.md"
  copy_dir "$SRC_DIR/core/skills/arabic-design" "$DEST/skills/arabic-design"
}

install_memory() {
  copy_file "$SRC_DIR/core/commands/mem-load.md" "$DEST/commands/mem-load.md"
  copy_file "$SRC_DIR/core/commands/mem-query.md" "$DEST/commands/mem-query.md"
  copy_file "$SRC_DIR/core/commands/mem-save.md" "$DEST/commands/mem-save.md"
  copy_file "$SRC_DIR/core/commands/memory-search.md" "$DEST/commands/memory-search.md"
  copy_file "$SRC_DIR/core/commands/project-context.md" "$DEST/commands/project-context.md"
  copy_file "$SRC_DIR/core/commands/session-summary.md" "$DEST/commands/session-summary.md"
  copy_file "$SRC_DIR/install/init-memory.js" "$DEST/scripts/init-memory.js"
  copy_file "$SRC_DIR/install/migrate-memory-scope.js" "$DEST/scripts/migrate-memory-scope.js"
}

install_quality() {
  copy_file "$SRC_DIR/core/commands/qa.md" "$DEST/commands/qa.md"
  copy_file "$SRC_DIR/core/commands/auto-verify.md" "$DEST/commands/auto-verify.md"
  copy_file "$SRC_DIR/core/commands/eval-last.md" "$DEST/commands/eval-last.md"
  copy_file "$SRC_DIR/core/commands/compare-models.md" "$DEST/commands/compare-models.md"
  copy_file "$SRC_DIR/core/workflows/auto-verify.js" "$DEST/workflows/auto-verify.js"
  copy_file "$SRC_DIR/core/workflows/code-quality-pipeline.js" "$DEST/workflows/code-quality-pipeline.js"
  copy_file "$SRC_DIR/core/workflows/deep-review.js" "$DEST/workflows/deep-review.js"
  copy_file "$SRC_DIR/core/workflows/quick-check.js" "$DEST/workflows/quick-check.js"
  copy_file "$SRC_DIR/core/workflows/canary.js" "$DEST/workflows/canary.js"
}

install_worktrees() {
  copy_file "$SRC_DIR/core/commands/worktree-new.md" "$DEST/commands/worktree-new.md"
  copy_file "$SRC_DIR/core/commands/worktree-done.md" "$DEST/commands/worktree-done.md"
}

if [[ "$LIST_ONLY" -eq 1 ]]; then
  echo "Available packs: core arabic memory quality worktrees"
  exit 0
fi

if [[ -z "$PACKS" ]]; then
  echo "Specify --packs, for example: --packs core,arabic" >&2
  usage
  exit 1
fi

IFS=',' read -r -a SELECTED <<< "$PACKS"
HAS_CORE=0
for pack in "${SELECTED[@]}"; do
  pack="$(echo "$pack" | tr -d '[:space:]')"
  [[ "$pack" == "core" ]] && HAS_CORE=1
done

if [[ "$HAS_CORE" -eq 0 ]]; then
  echo "Adding required pack: core"
  SELECTED=("core" "${SELECTED[@]}")
fi

if [[ -z "$SRC_DIR" ]]; then
  CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/nizam-deepseek"
  if [[ -d "$CACHE/.git" ]]; then
    git -C "$CACHE" pull --ff-only
  else
    mkdir -p "$(dirname "$CACHE")"
    git clone --depth 1 "$SRC_REPO" "$CACHE"
  fi
  SRC_DIR="$CACHE"
fi

if [[ ! -f "$SRC_DIR/core/CLAUDE.md" ]]; then
  echo "Source checkout not found: $SRC_DIR" >&2
  exit 1
fi

mkdir -p "$DEST"
echo "Installing into $DEST from $SRC_DIR"

for pack in "${SELECTED[@]}"; do
  pack="$(echo "$pack" | tr -d '[:space:]')"
  echo "Pack: $pack"
  case "$pack" in
    core) install_core ;;
    arabic) install_arabic ;;
    memory) install_memory ;;
    quality) install_quality ;;
    worktrees) install_worktrees ;;
    *) echo "Unknown pack: $pack" >&2; exit 1 ;;
  esac
done

echo "Done."
