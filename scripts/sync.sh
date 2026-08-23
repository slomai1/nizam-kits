#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC_REPO="https://github.com/slomai1/nizam-deepseek.git"
SRC_DIR="${NIZAM_SRC:-}"
CLEANUP=0

if [[ -z "$SRC_DIR" ]]; then
  SRC_DIR="$(mktemp -d)"
  CLEANUP=1
  git clone --depth 1 "$SRC_REPO" "$SRC_DIR"
fi

if [[ ! -d "$SRC_DIR/core" ]]; then
  echo "Source tree not found: $SRC_DIR" >&2
  exit 1
fi

copy_tree() {
  local name="$1"
  mkdir -p "$ROOT/$name"
  rm -rf "$ROOT/$name"
  cp -R "$SRC_DIR/$name" "$ROOT/$name"
  echo "synced $name/"
}

copy_tree core
copy_tree docs
copy_tree templates
copy_tree tools

mkdir -p "$ROOT/install"
find "$ROOT/install" -maxdepth 1 -type f -name '*.js' -delete
if compgen -G "$SRC_DIR/install/*.js" > /dev/null; then
  cp "$SRC_DIR/install/"*.js "$ROOT/install/"
  echo "synced install/*.js"
fi

if [[ "$CLEANUP" -eq 1 ]]; then
  rm -rf "$SRC_DIR"
fi

echo "Library sync complete. Installer scripts were not copied."
