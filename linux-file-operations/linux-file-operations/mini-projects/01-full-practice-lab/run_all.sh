#!/usr/bin/env bash
# ============================================================
# Mini Project 01 — Full Practice Lab
# Runs all 13 tasks (cp, mv, rsync, install, rename) in one go.
# Safe to run multiple times — cleans up its own scratch folder.
# ============================================================

set -u

LAB_ROOT="$(pwd)/full_lab"

# Clean previous run
rm -rf "$LAB_ROOT"
mkdir -p "$LAB_ROOT"
cd "$LAB_ROOT" || exit 1

echo "============================================================"
echo "Mini Project 01 — Full Practice Lab"
echo "Working inside: $LAB_ROOT"
echo "============================================================"
echo ""

# ===== SECTION A: cp and mv tests (Tasks 1–10) =====
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "SECTION A — cp and mv"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

mkdir -p source backup
echo "A" > source/a.txt
echo "B" > source/b.txt

echo "▶ cp -v source/a.txt backup/"
cp -v source/a.txt backup/

echo "▶ cp -rv source/ backup_source/"
cp -rv source/ backup_source/

echo "▶ mv source/b.txt source/b_renamed.txt"
mv source/b.txt source/b_renamed.txt

echo "▶ ls source/ backup/ backup_source/"
ls source/ backup/ backup_source/
echo ""

# ===== SECTION B: rsync test (Task 11) =====
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "SECTION B — rsync"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo "▶ echo C > source/c.txt"
echo "C" > source/c.txt

echo "▶ First rsync -avh source/ backup/"
rsync -avh source/ backup/

echo "▶ Modify c.txt and re-sync (only c.txt should transfer)"
echo "C (updated)" > source/c.txt
rsync -avh source/ backup/

echo "▶ Result: backup/c.txt now contains: $(cat backup/c.txt)"
echo ""

# ===== SECTION C: install test (Task 12) =====
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "SECTION C — install"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

cat > script.sh << 'EOF'
#!/bin/bash
echo "It ran!"
EOF

echo "▶ Created script.sh"
echo "▶ install -m 755 script.sh my_bin/"
mkdir -p my_bin
install -m 755 script.sh my_bin/
echo "▶ Permissions on my_bin/script.sh: $(ls -l my_bin/script.sh | awk '{print $1}')"
echo "▶ Running it:"
./my_bin/script.sh
echo ""

# ===== SECTION D: rename test (Task 13) =====
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "SECTION D — rename"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if command -v rename >/dev/null 2>&1; then
    mkdir -p rename_test && cd rename_test
    touch f1.txt f2.txt f3.txt
    echo "▶ Created: $(ls | tr '\n' ' ')"
    echo "▶ rename -v 's/\\.txt\$/.bak/' *.txt"
    rename -v 's/\.txt$/.bak/' *.txt
    echo "▶ After: $(ls | tr '\n' ' ')"
    echo "▶ rename -v 's/\\.bak\$/.txt/' *.bak"
    rename -v 's/\.bak$/.txt/' *.bak
    echo "▶ After: $(ls | tr '\n' ' ')"
    cd "$LAB_ROOT"
else
    echo "⚠ Skipped rename section — 'rename' command not installed."
    echo "  Install with:  sudo apt install rename"
fi
echo ""

# ===== Final summary =====
echo "============================================================"
echo "✅ Mini Project 01 complete!"
echo "   All 13 tasks executed. Scratch files are in: $LAB_ROOT"
echo "   Remove them anytime with:  rm -rf $LAB_ROOT"
echo "============================================================"
