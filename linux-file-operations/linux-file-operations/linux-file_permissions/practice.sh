#!/usr/bin/env bash
# ============================================================
# File Permissions — Practice Lab (Tasks 1–7)
# Safe to run multiple times. All work happens inside a scratch folder.
# ============================================================

set -u

LAB_DIR="$(pwd)/perm_lab_scratch"

# Clean any previous run
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"
cd "$LAB_DIR" || exit 1

echo "============================================================"
echo "🔐 File Permissions — Practice Lab"
echo "Working inside: $LAB_DIR"
echo "============================================================"
echo ""

# ------------------------------------------------------------
# Setup — create a test file
# ------------------------------------------------------------
echo "▶ Setup: Create test file"
echo "This is a test file" > test.txt
echo "   ls -l test.txt"
ls -l test.txt | awk '{print "   →", $1, $3, $4, $5, $9}'
echo ""

# ------------------------------------------------------------
# Task 1 — Read permissions
# ------------------------------------------------------------
echo "▶ Task 1: Read permissions"
PERMS=$(ls -l test.txt | awk '{print $1}')
echo "   Permission string: $PERMS"
echo "   Owner  can: $(echo $PERMS | cut -c2-4)  (read = r, write = w, execute = x)"
echo "   Group  can: $(echo $PERMS | cut -c5-7)"
echo "   Others can: $(echo $PERMS | cut -c8-10)"
echo ""

# ------------------------------------------------------------
# Task 2 — Numeric chmod
# ------------------------------------------------------------
echo "▶ Task 2: Numeric chmod"
chmod 755 test.txt
echo "   chmod 755 → $(ls -l test.txt | awk '{print $1}')   (expect -rwxr-xr-x)"

chmod 644 test.txt
echo "   chmod 644 → $(ls -l test.txt | awk '{print $1}')   (expect -rw-r--r--)"

chmod 600 test.txt
echo "   chmod 600 → $(ls -l test.txt | awk '{print $1}')   (expect -rw-------)"

chmod 400 test.txt
echo "   chmod 400 → $(ls -l test.txt | awk '{print $1}')   (expect -r--------"
echo ""

# ------------------------------------------------------------
# Task 3 — Symbolic chmod
# ------------------------------------------------------------
echo "▶ Task 3: Symbolic chmod"
chmod 644 test.txt
echo "   Reset to 644 → $(ls -l test.txt | awk '{print $1}')"

chmod u+x test.txt
echo "   chmod u+x   → $(ls -l test.txt | awk '{print $1}')   (owner got x)"

chmod g+w test.txt
echo "   chmod g+w   → $(ls -l test.txt | awk '{print $1}')   (group got w)"

chmod o-r test.txt
echo "   chmod o-r   → $(ls -l test.txt | awk '{print $1}')   (others lost r)"

chmod a+r test.txt
echo "   chmod a+r   → $(ls -l test.txt | awk '{print $1}')   (all got r)"
echo ""

# ------------------------------------------------------------
# Task 4 — Directory permissions
# ------------------------------------------------------------
echo "▶ Task 4: Directory permissions"
mkdir mydir
echo "   Default    → $(ls -ld mydir | awk '{print $1}')   (usually drwxr-xr-x)"

chmod 700 mydir
echo "   chmod 700  → $(ls -ld mydir | awk '{print $1}')   (expect drwx------)"

chmod 755 mydir
echo "   chmod 755  → $(ls -ld mydir | awk '{print $1}')   (expect drwxr-xr-x)"
echo "   Note: On a directory, x means 'can cd into it'."
echo ""

# ------------------------------------------------------------
# Task 5 — Complete permission table
# ------------------------------------------------------------
echo "▶ Task 5: Complete permission table"
echo "   Mode   Permission"
echo "   ───────────────────"
for n in 000 400 600 644 700 755 777; do
    touch f_$n
    chmod $n f_$n
    printf "   %s   →  %s\n" "$n" "$(ls -l f_$n | awk '{print $1}')"
done
rm -f f_*
echo ""

# ------------------------------------------------------------
# Task 6 — chown (change owner)
# ------------------------------------------------------------
echo "▶ Task 6: chown (change owner)"
touch owner_test.txt
echo "   Created owner_test.txt"
echo "   Current owner: $(ls -l owner_test.txt | awk '{print $3":"$4}')"

# Try to use sudo; if not available, skip gracefully
if sudo -n true 2>/dev/null; then
    sudo chown root owner_test.txt
    echo "   After 'sudo chown root' → owner: $(ls -l owner_test.txt | awk '{print $3":"$4}')"
    sudo chown $USER owner_test.txt
    echo "   After 'sudo chown $USER' → owner: $(ls -l owner_test.txt | awk '{print $3":"$4}')"
else
    echo "   ⚠ sudo not available non-interactively — skipping the actual chown."
    echo "     To try this yourself, run in your terminal:"
    echo "       sudo chown root owner_test.txt && ls -l owner_test.txt"
    echo "       sudo chown \$USER owner_test.txt && ls -l owner_test.txt"
fi
echo ""

# ------------------------------------------------------------
# Task 7 — umask
# ------------------------------------------------------------
echo "▶ Task 7: umask"
ORIGINAL_UMASK=$(umask)
echo "   Current umask (numeric):  $ORIGINAL_UMASK"
echo "   Current umask (symbolic): $(umask -S)"

echo ""
echo "   Testing umask 077 (secure mode):"
umask 077
touch newfile_secure.txt
echo "   umask 077 → new file: $(ls -l newfile_secure.txt | awk '{print $1}')   (expect -rw-------)"

echo ""
echo "   Testing umask 022 (default mode):"
umask 022
touch newfile_default.txt
echo "   umask 022 → new file: $(ls -l newfile_default.txt | awk '{print $1}')   (expect -rw-r--r--)"

# Restore original
umask $ORIGINAL_UMASK
echo ""

# ------------------------------------------------------------
# Summary
# ------------------------------------------------------------
echo "============================================================"
echo "✅ Practice Lab complete!"
echo "   All 7 tasks executed. Scratch files are in: $LAB_DIR"
echo "   Remove them anytime with:  rm -rf $LAB_DIR"
echo "============================================================"
echo ""
echo "Key takeaways:"
echo "  • r=4, w=2, x=1  →  sum for each of u/g/o"
echo "  • Numeric chmod (755) sets exact permissions"
echo "  • Symbolic chmod (u+x) tweaks one bit"
echo "  • Directory x = permission to cd into it"
echo "  • umask subtracts from default (666 files, 777 dirs)"
echo "  • chown needs sudo"
