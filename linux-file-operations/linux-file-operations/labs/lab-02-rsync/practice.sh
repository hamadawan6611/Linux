#!/usr/bin/env bash
# ============================================================
# Lab 02 — rsync (Task 11)
# Demonstrates: first sync, incremental sync, --delete mirror
# ============================================================

set -u

LAB_DIR="$(pwd)/lab02_scratch"

# Clean previous run
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"
cd "$LAB_DIR" || exit 1

echo "============================================================"
echo "Lab 02 — rsync"
echo "Working inside: $LAB_DIR"
echo "============================================================"
echo ""

# ------------------------------------------------------------
# Step 1 — Create a source folder with three files
# ------------------------------------------------------------
echo "▶ Step 1: Create source folder with three files"
mkdir rsync_source
echo "File A content" > rsync_source/a.txt
echo "File B content" > rsync_source/b.txt
echo "File C content" > rsync_source/c.txt
echo "   rsync_source/ contains: $(ls rsync_source/ | tr '\n' ' ')"
echo ""

# ------------------------------------------------------------
# Step 2 — First rsync — copies everything
# ------------------------------------------------------------
echo "▶ Step 2: First rsync -avh (copies everything)"
rsync -avh rsync_source/ backup/
echo "   backup/ now contains: $(ls backup/ | tr '\n' ' ')"
echo ""

# ------------------------------------------------------------
# Step 3 — Modify one file, re-run rsync — only that file is copied
# ------------------------------------------------------------
echo "▶ Step 3: Modify one file and re-sync"
echo "Updated A content" > rsync_source/a.txt
echo "   Running rsync -avh again..."
rsync -avh rsync_source/ backup/
echo "   ↑ Notice only a.txt was transferred this time."
echo "   backup/a.txt now contains: $(cat backup/a.txt)"
echo ""

# ------------------------------------------------------------
# Step 4 — --delete: mirror destination to source
# ------------------------------------------------------------
echo "▶ Step 4: --delete flag (mirror)"
echo "   Removing b.txt from source..."
rm rsync_source/b.txt
echo "   Before --delete: backup/ has $(ls backup/ | tr '\n' ' ')"
rsync -avh --delete rsync_source/ backup/
echo "   After  --delete: backup/ has $(ls backup/ | tr '\n' ' ')"
echo "   ↑ b.txt was removed from backup to match source exactly."
echo ""

# ------------------------------------------------------------
# Step 5 — Demonstrate the trailing-slash trap
# ------------------------------------------------------------
echo "▶ Step 5: Trailing slash trap (informational)"
echo "   rsync -avh rsync_source/ backup/   → copies CONTENTS into backup/"
echo "   rsync -avh rsync_source backup/    → copies the FOLDER itself"
echo "   Demo with NO trailing slash:"
rm -rf backup2/
rsync -avh rsync_source backup2/
echo "   backup2/ now contains: $(ls backup2/ | tr '\n' ' ')"
echo "   ↑ Notice 'rsync_source' as a subfolder, not the loose files."
echo ""

# ------------------------------------------------------------
# Summary
# ------------------------------------------------------------
echo "============================================================"
echo "✅ Lab 02 complete. Scratch files are in: $LAB_DIR"
echo "   Remove them anytime with:  rm -rf $LAB_DIR"
echo "============================================================"
