#!/usr/bin/env bash
# ============================================================
# Mini Project — Secure Script Vault
#
# Copies files into a vault/ folder and applies restrictive perms.
#
# BONUS FEATURE: Asks the user for the permission mode
#                (defaults to 600 if they press Enter).
# Non-interactive: pass --mode NNN to skip the prompt.
#
# Usage:
#   ./mini-project.sh file1 file2 ...
#   ./mini-project.sh --mode 400 file1 file2 ...
# ============================================================

set -u

# ---------- defaults ----------
MODE=""
DEFAULT_MODE="600"
VAULT_DIR="vault"

# ---------- parse args ----------
ARGS=()
EXPECT_MODE=0
for arg in "$@"; do
    if [ "$arg" = "--mode" ]; then
        EXPECT_MODE=1
        continue
    fi
    if [ "$EXPECT_MODE" = "1" ]; then
        MODE="$arg"
        EXPECT_MODE=0
        continue
    fi
    ARGS+=("$arg")
done

# ---------- helper: validate mode ----------
validate_mode() {
    local m="$1"
    # must be 3 chars, all digits 0-7
    if ! [[ "$m" =~ ^[0-7]{3}$ ]]; then
        return 1
    fi
    return 0
}

# ---------- usage ----------
if [ ${#ARGS[@]} -eq 0 ]; then
    cat <<EOF
Usage:
  $0 [--mode NNN] file1 file2 ...

Options:
  --mode NNN   Permission mode to apply (3 digits, 0-7 each). Default: 600.

Examples:
  $0 secret.txt                          # asks for mode interactively
  $0 --mode 400 secret.key api.key       # non-interactive, mode 400

Common modes:
  600  rw-------   (private file — default)
  640  rw-r-----   (group can read)
  400  r--------   (read-only secret)
  700  rwx------   (private executable)
EOF
    exit 1
fi

# ---------- ask for mode if not given via --mode ----------
if [ -z "$MODE" ]; then
    echo ""
    echo "🔐 Permission mode to apply?"
    echo "   Common choices: 600 (rw-------), 640 (rw-r-----), 400 (r--------)"
    printf "   Press Enter for default (%s): " "$DEFAULT_MODE"
    read -r USER_MODE
    MODE="${USER_MODE:-$DEFAULT_MODE}"
    echo ""
fi

# ---------- validate mode ----------
if ! validate_mode "$MODE"; then
    echo "❌ Invalid permission mode: '$MODE'"
    echo "   Must be exactly 3 digits, each between 0 and 7 (e.g. 600, 640, 400)."
    exit 1
fi

# ---------- create vault directory ----------
mkdir -p "$VAULT_DIR"
chmod 700 "$VAULT_DIR"

# ---------- copy and secure each file ----------
SUCCESS_COUNT=0
FAIL_COUNT=0

for file in "${ARGS[@]}"; do
    if [ ! -f "$file" ]; then
        echo "⚠️  $file does not exist (skipped)"
        FAIL_COUNT=$((FAIL_COUNT + 1))
        continue
    fi

    BASENAME=$(basename "$file")
    cp "$file" "$VAULT_DIR/"
    chmod "$MODE" "$VAULT_DIR/$BASENAME"
    echo "✅ $file → $VAULT_DIR/$BASENAME (mode: $MODE)"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
done

# ---------- summary ----------
echo ""
echo "📊 Summary: $SUCCESS_COUNT secured, $FAIL_COUNT skipped"
if [ "$SUCCESS_COUNT" -gt 0 ]; then
    echo ""
    echo "📁 Files in $VAULT_DIR/:"
    ls -l "$VAULT_DIR/"
fi
