#!/usr/bin/env bash
# ============================================================
# Lab 03 — install (Task 12)
# Demonstrates: create script, install with -m 755 (executable),
#               install with -m 644 (read-only, will fail to run)
# ============================================================

set -u

LAB_DIR="$(pwd)/lab03_scratch"

rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"
cd "$LAB_DIR" || exit 1

echo "============================================================"
echo "Lab 03 — install"
echo "Working inside: $LAB_DIR"
echo "============================================================"
echo ""

# ------------------------------------------------------------
# Step 1 — Create a test script (no execute permission yet)
# ------------------------------------------------------------
echo "▶ Step 1: Create a test script"
cat > script.sh << 'EOF'
#!/bin/bash
echo "Hello! This is a test script."
EOF
echo "   Created script.sh"
echo "   Current permissions: $(ls -l script.sh | awk '{print $1}')"
echo "   ↑ Notice no 'x' bits — script is not yet executable."
echo ""

# ------------------------------------------------------------
# Step 2 — install -m 755 → executable script
# ------------------------------------------------------------
echo "▶ Step 2: install -m 755 script.sh my_bin/"
mkdir -p my_bin
install -m 755 script.sh my_bin/
echo "   Installed to my_bin/script.sh"
echo "   New permissions: $(ls -l my_bin/script.sh | awk '{print $1}')"
echo "   Running the script:"
./my_bin/script.sh
echo ""

# ------------------------------------------------------------
# Step 3 — install -m 644 → read-only, will NOT execute
# ------------------------------------------------------------
echo "▶ Step 3: install -m 644 script.sh my_bin/script_readonly.sh"
install -m 644 script.sh my_bin/script_readonly.sh
echo "   Installed to my_bin/script_readonly.sh"
echo "   New permissions: $(ls -l my_bin/script_readonly.sh | awk '{print $1}')"
echo "   Trying to run it:"
if ./my_bin/script_readonly.sh 2>/dev/null; then
    echo "   (it ran — unexpected!)"
else
    echo "   → Permission denied (as expected for 644 mode)"
fi
echo ""

# ------------------------------------------------------------
# Step 4 — install -d → create a directory with explicit mode
# ------------------------------------------------------------
echo "▶ Step 4: install -d -m 755 logs"
install -d -m 755 logs
echo "   Created directory: logs"
echo "   Permissions: $(ls -ld logs | awk '{print $1}')"
echo ""

# ------------------------------------------------------------
# Summary
# ------------------------------------------------------------
echo "============================================================"
echo "✅ Lab 03 complete. Scratch files are in: $LAB_DIR"
echo "   Remove them anytime with:  rm -rf $LAB_DIR"
echo "============================================================"
echo ""
echo "Key takeaways:"
echo "  • install -m 755 → executable script (rwxr-xr-x)"
echo "  • install -m 644 → read-only file, will NOT execute"
echo "  • install -d     → create a directory with explicit mode"
echo "  • install = cp + chmod in one atomic step"
