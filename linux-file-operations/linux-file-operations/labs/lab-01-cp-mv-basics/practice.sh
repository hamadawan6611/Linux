#!/usr/bin/env bash
# ============================================================
# Lab 01 — cp and mv basics (Tasks 1–10)
# Safe to run multiple times. All work happens inside a scratch folder.
# ============================================================

set -u

LAB_DIR="$(pwd)/lab01_scratch"

# Cleanup any previous run, then start fresh
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"
cd "$LAB_DIR" || exit 1

echo "============================================================"
echo "Lab 01 — cp and mv basics"
echo "Working inside: $LAB_DIR"
echo "============================================================"
echo ""

# ------------------------------------------------------------
# Task 1 — Simple file copy
# ------------------------------------------------------------
echo "▶ Task 1: Simple file copy"
echo "Original content" > notes.txt
cp notes.txt notes_backup.txt
echo "   cp notes.txt notes_backup.txt"
echo "   Result: $(ls notes.txt notes_backup.txt 2>/dev/null | tr '\n' ' ')"
echo ""

# ------------------------------------------------------------
# Task 2 — Copy multiple files into a folder
# ------------------------------------------------------------
echo "▶ Task 2: Copy multiple files into a folder"
echo "A" > file1.txt
echo "B" > file2.txt
mkdir -p backup
cp file1.txt file2.txt backup/
echo "   cp file1.txt file2.txt backup/"
echo "   backup/ contains: $(ls backup/ | tr '\n' ' ')"
echo ""

# ------------------------------------------------------------
# Task 3 — Copy an entire directory with -r
# ------------------------------------------------------------
echo "▶ Task 3: Copy an entire directory (recursive)"
mkdir -p source
echo "x" > source/x.txt
echo "y" > source/y.txt
cp -r source/ backup_source/
echo "   cp -r source/ backup_source/"
echo "   backup_source/ contains: $(ls backup_source/ | tr '\n' ' ')"
echo ""

# ------------------------------------------------------------
# Task 4 — Interactive prompt (-i)
# ------------------------------------------------------------
echo "▶ Task 4: Interactive prompt (-i)"
# In a script we pipe 'n' so the overwrite is declined; in a real terminal
# you would type y or n yourself.
echo "newer content" > notes.txt
echo "n" | cp -i notes.txt notes_backup.txt
echo "   cp -i notes.txt notes_backup.txt  (auto-answered 'n')"
echo "   notes_backup.txt still says: $(cat notes_backup.txt)"
echo ""

# ------------------------------------------------------------
# Task 5 — Verbose output (-v)
# ------------------------------------------------------------
echo "▶ Task 5: Verbose output (-v)"
cp -v file1.txt backup/
echo "   (the line above was printed by cp -v itself)"
echo ""

# ------------------------------------------------------------
# Task 6 — Move a file with mv
# ------------------------------------------------------------
echo "▶ Task 6: Move a file with mv"
echo "important" > important.txt
mv important.txt backup/
echo "   mv important.txt backup/"
echo "   important.txt in cwd? $([ -f important.txt ] && echo yes || echo no)"
echo "   backup/important.txt exists? $([ -f backup/important.txt ] && echo yes || echo no)"
echo ""

# ------------------------------------------------------------
# Task 7 — Rename a file with mv
# ------------------------------------------------------------
echo "▶ Task 7: Rename a file with mv"
mv file1.txt renamed_file.txt
echo "   mv file1.txt renamed_file.txt"
echo "   renamed_file.txt exists? $([ -f renamed_file.txt ] && echo yes || echo no)"
echo ""

# ------------------------------------------------------------
# Task 8 — No-clobber safety (-n)
# ------------------------------------------------------------
echo "▶ Task 8: No-clobber safety (-n)"
echo "alpha" > a.txt
echo "beta"  > b.txt
mv -n a.txt b.txt
echo "   mv -n a.txt b.txt"
echo "   b.txt still contains: $(cat b.txt)  (should still be 'beta')"
echo "   a.txt still exists? $([ -f a.txt ] && echo yes || echo no)  (should be yes)"
echo ""

# ------------------------------------------------------------
# Task 9 — Update only newer files (-u)
# ------------------------------------------------------------
echo "▶ Task 9: Update only newer files (-u)"
echo "old" > old.txt
sleep 1
echo "new" > new.txt
cp -u new.txt old.txt
echo "   cp -u new.txt old.txt"
echo "   old.txt now contains: $(cat old.txt)  (should be 'new')"
echo ""

# ------------------------------------------------------------
# Task 10 — Combine multiple flags (-ruv)
# ------------------------------------------------------------
echo "▶ Task 10: Combine multiple flags (-ruv)"
rm -rf source/ backup_combined/
mkdir -p source
echo "fresh" > source/fresh.txt
cp -ruv source/ backup_combined/
echo "   cp -ruv source/ backup_combined/"
echo "   backup_combined/ contains: $(ls backup_combined/ | tr '\n' ' ')"
echo ""

# ------------------------------------------------------------
# Summary
# ------------------------------------------------------------
echo "============================================================"
echo "✅ Lab 01 complete. Scratch files are in: $LAB_DIR"
echo "   Remove them anytime with:  rm -rf $LAB_DIR"
echo "============================================================"
