#!/usr/bin/env bash
# ============================================================
# Mini Project 02 — Smart Backup System
# Usage:
#   ./backup.sh                          SOURCE  BACKUP
#   ./backup.sh --delete                 SOURCE  BACKUP
# ============================================================

set -euo pipefail

# ----- usage -----
usage() {
    cat <<EOF
Usage:
  $0 [--delete] SOURCE BACKUP

Options:
  --delete   Also remove files in BACKUP that no longer exist in SOURCE
             (mirror mode). Use with care!

Examples:
  $0 ~/Documents /mnt/external/Documents_backup
  $0 --delete ~/projects /mnt/nas/projects_mirror
EOF
    exit 1
}

# ----- parse args -----
DELETE_FLAG=""
if [ "${1:-}" = "--delete" ]; then
    DELETE_FLAG="--delete"
    shift
fi

[ $# -lt 2 ] && usage

SOURCE="$1"
BACKUP="$2"

# ----- validate -----
if [ ! -d "$SOURCE" ]; then
    echo "❌ Source directory does not exist: $SOURCE"
    exit 1
fi

# ----- ensure source path ends with / so contents are synced -----
SOURCE_DIR="${SOURCE%/}/"

# ----- create backup root if needed -----
mkdir -p "$BACKUP"

# ----- run rsync -----
echo "============================================================"
echo "Smart Backup System"
echo "  Source : $SOURCE_DIR"
echo "  Backup : $BACKUP/"
if [ -n "$DELETE_FLAG" ]; then
    echo "  Mode   : MIRROR (--delete enabled)"
else
    echo "  Mode   : INCREMENTAL (safe, no deletions)"
fi
echo "============================================================"
echo ""

# Always do a dry-run preview first so the user can see what will happen
echo "▶ Dry-run preview:"
rsync -avh --dry-run $DELETE_FLAG "$SOURCE_DIR" "$BACKUP/"
echo ""

echo "▶ Real sync starting in 2 seconds... (Ctrl+C to abort)"
sleep 2

rsync -avh $DELETE_FLAG "$SOURCE_DIR" "$BACKUP/"

echo ""
echo "✅ Backup complete."
echo "   Files in backup: $(find "$BACKUP" -type f | wc -l)"
echo "   Total size:      $(du -sh "$BACKUP" | awk '{print $1}')"
