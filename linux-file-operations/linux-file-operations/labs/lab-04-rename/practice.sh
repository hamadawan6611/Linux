#!/usr/bin/env bash
# ============================================================
# Lab 04 — rename (Task 13)
# Demonstrates: dry-run, extension swap, word replace, prefix add
# Requires: the Perl-based 'rename' command (apt install rename)
# ============================================================

set -u

LAB_DIR="$(pwd)/lab04_scratch"

rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"
cd "$LAB_DIR" || exit 1

# Check that rename is available
if ! command -v rename >/dev/null 2>&1; then
    echo "❌ 'rename' is not installed."
    echo "   Install it with:  sudo apt install rename   (Ubuntu/Debian)"
    echo "                  or sudo dnf install prename  (Fedora/RHEL)"
    exit 1
fi

echo "============================================================"
echo "Lab 04 — rename"
echo "Working inside: $LAB_DIR"
echo "============================================================"
echo ""

# ------------------------------------------------------------
# Step 1 — Create test files
# ------------------------------------------------------------
echo "▶ Step 1: Create test files"
mkdir rename_test
cd rename_test
touch book1.txt book2.txt book3.txt notes.txt
echo "   Files: $(ls | tr '\n' ' ')"
echo ""

# ------------------------------------------------------------
# Step 2 — Dry run: .txt → .bak (nothing actually changes)
# ------------------------------------------------------------
echo "▶ Step 2: Dry-run preview (-n flag)"
echo "   Command: rename -n 's/\\.txt\$/.bak/' *.txt"
rename -n 's/\.txt$/.bak/' *.txt
echo "   ↑ Preview only. Files still: $(ls | tr '\n' ' ')"
echo ""

# ------------------------------------------------------------
# Step 3 — Real run: .txt → .bak (verbose)
# ------------------------------------------------------------
echo "▶ Step 3: Real run with -v"
rename -v 's/\.txt$/.bak/' *.txt
echo "   Files now: $(ls | tr '\n' ' ')"
echo ""

# ------------------------------------------------------------
# Step 4 — Reverse: .bak → .txt
# ------------------------------------------------------------
echo "▶ Step 4: Reverse .bak → .txt"
rename -v 's/\.bak$/.txt/' *.bak
echo "   Files now: $(ls | tr '\n' ' ')"
echo ""

# ------------------------------------------------------------
# Step 5 — Replace word inside name: book → chapter
# ------------------------------------------------------------
echo "▶ Step 5: Replace word 'book' → 'chapter'"
rename -v 's/book/chapter/' *.txt
echo "   Files now: $(ls | tr '\n' ' ')"
echo ""

# ------------------------------------------------------------
# Step 6 — Add prefix using ^ anchor
# ------------------------------------------------------------
echo "▶ Step 6: Add prefix 'v2_' to every file"
rename -n 's/^/v2_/' *.txt            # dry-run first
echo "   ↑ Dry-run preview."
rename -v 's/^/v2_/' *.txt            # real run
echo "   Files now: $(ls | tr '\n' ' ')"
echo ""

cd "$LAB_DIR"

# ------------------------------------------------------------
# Summary
# ------------------------------------------------------------
echo "============================================================"
echo "✅ Lab 04 complete. Scratch files are in: $LAB_DIR"
echo "   Remove them anytime with:  rm -rf $LAB_DIR"
echo "============================================================"
echo ""
echo "Key takeaways:"
echo "  • ALWAYS run with -n first to preview"
echo "  • s/old/new/  → substitute first occurrence"
echo "  • s/old/new/g → substitute ALL occurrences"
echo "  • ^ matches start of name,  \$ matches end"
echo "  • Escape special chars:  use \\. for a literal dot"
