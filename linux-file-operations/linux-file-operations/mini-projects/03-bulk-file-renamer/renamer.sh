#!/usr/bin/env bash
# ============================================================
# Mini Project 03 — Bulk File Renamer
# Usage:
#   ./renamer.sh 's/old/new/' '*.txt'
#   ./renamer.sh --force 's/^/v2_/' '*.jpg'
#
# Always shows a dry-run preview first, then asks for confirmation.
# ============================================================

set -euo pipefail

# ----- check rename is installed -----
if ! command -v rename >/dev/null 2>&1; then
    echo "❌ 'rename' is not installed."
    echo "   Install with:  sudo apt install rename   (Ubuntu/Debian)"
    echo "              or  sudo dnf install prename  (Fedora/RHEL)"
    exit 1
fi

# ----- parse args -----
FORCE=0
if [ "${1:-}" = "--force" ]; then
    FORCE=1
    shift
fi

if [ $# -lt 2 ]; then
    cat <<EOF
Usage:
  $0 [--force] 'PATTERN' 'GLOB'

Examples:
  $0 's/\\.txt\$/.md/'   '*.txt'
  $0 's/ /_/g'           '*.docx'
  $0 --force 's/^/v2_/'  '*.jpg'
EOF
    exit 1
fi

PATTERN="$1"
GLOB="$2"

# ----- expand the glob to count matching files -----
shopt -s nullglob
mapfile -t FILES <<< $(eval ls -1 $GLOB 2>/dev/null)
shopt -u nullglob

if [ ${#FILES[@]} -eq 0 ] || [ -z "${FILES[0]}" ]; then
    echo "⚠ No files match the glob: $GLOB"
    exit 0
fi

echo "============================================================"
echo "Bulk File Renamer"
echo "  Pattern : $PATTERN"
echo "  Glob    : $GLOB"
echo "  Matches : ${#FILES[@]} file(s)"
echo "============================================================"
echo ""

# ----- step 1: dry-run preview -----
echo "▶ Dry-run preview (nothing will be changed):"
rename -n "$PATTERN" $GLOB
echo ""

# ----- step 2: confirm or skip -----
if [ "$FORCE" -eq 1 ]; then
    echo "▶ --force flag detected, skipping confirmation."
    REPLY="y"
else
    read -p "▶ Apply these renames? [y/N] " REPLY
fi

case "$REPLY" in
    y|Y|yes|YES)
        echo ""
        echo "▶ Running rename -v \"$PATTERN\" $GLOB"
        rename -v "$PATTERN" $GLOB
        echo ""
        echo "✅ Done. Renamed ${#FILES[@]} file(s)."
        ;;
    *)
        echo "↩ Cancelled. No files were renamed."
        exit 0
        ;;
esac
