#!/bin/bash
# Configuration
OUTPUT_FILE="/tmp/lams_output.txt"
AUTO_FIX_LOG="/tmp/indent_fix_log.txt"
INDENT_SPACES=2

# Create lint_dir for isolated lint/fix
mkdir -p lint_dir

# Step 0: Get only changed LKML files
git fetch origin master
CHANGED_FILES=$(git diff --name-only --diff-filter=d origin/main | grep '\.lkml$')

if [[ -z "$CHANGED_FILES" ]]; then
 echo "No LookML files changed. Skipping LAMS check."
 exit 0
fi

for file in $CHANGED_FILES; do
 mkdir -p lint_dir/$(dirname "$file")
 cp "$file" "lint_dir/$file"
done

# Step 1: Run LAMS on copied files
echo "Running LAMS on changed files..."
lams lint_dir > "$OUTPUT_FILE"

# Step 2: Check for W1 indentation issues
W1_COUNT=$(grep -c 'W1' "$OUTPUT_FILE")
if [[ "$W1_COUNT" -eq 0 ]]; then
 echo "✅ No W1 indentation issues found!"
 exit 0
fi

echo "⚠️ Found $W1_COUNT W1 indentation issues. Attempting to auto-fix..."
echo "Fix log saved to: $AUTO_FIX_LOG"
echo "=== Auto-fix results ===" > "$AUTO_FIX_LOG"

# Step 3: Fix indentation in only changed files
echo "$CHANGED_FILES" | while read -r file; do
 echo "Fixing indentation in: $file" | tee -a "$AUTO_FIX_LOG"

 awk -v SPACES="$INDENT_SPACES" '
 BEGIN { indent = 0; }
 {
   line = $0
   gsub(/^[ \t]+/, "", line)
   if (line ~ /^[}]/) indent -= 1
   pad = ""
   for (i = 0; i < indent * SPACES; i++) pad = pad " "
   print pad line
   if (line ~ /[{][ ]*$/) indent += 1
 }
 ' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
done

echo "✅ Auto-fix complete. Re-run LAMS to verify." | tee -a "$AUTO_FIX_LOG"
