#!/bin/bash

clear
echo "----------------------------------------"
echo "   LeetCode Solution Generator (v2)   "
echo "----------------------------------------"

# 1. Prompt for Language
echo "Select Language:"
echo "1) Python"
echo "2) C++"
echo "3) JavaScript"
read -p "Enter choice [1-3]: " LANG_CHOICE

case "$LANG_CHOICE" in
    1)
        EXT="py"
        COMMENT_START='"""'
        COMMENT_END='"""'
        CLASS_STUB="class Solution:
    def solve(self):
        pass"
        ;;
    2)
        EXT="cpp"
        COMMENT_START="/*"
        COMMENT_END="*/"
        CLASS_STUB="class Solution {
public:
    // implementation
};"
        ;;
    3)
        EXT="js"
        COMMENT_START="/**"
        COMMENT_END=" */"
        CLASS_STUB="/**
 * @param {number[]} nums
 * @return {void}
 */
var solution = function(nums) {
    
};"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# 2. Prompt for Problem Details & Generate Filename
echo ""
read -p "Problem Number (e.g., 5): " PROBLEM_NUM
read -p "Problem Name (e.g., Longest Palindromic Substring): " PROBLEM_NAME_INPUT

# Format: Pad number with zeros to 4 digits (e.g., 5 -> 0005)
FORMATTED_NUM=$(printf "%04d" "$PROBLEM_NUM")

# Format: Convert name to lowercase and replace spaces with underscores
# 'tr' handles the translation of characters
FORMATTED_NAME=$(echo "$PROBLEM_NAME_INPUT" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')

# Construct final filename
FILENAME="solutions/${FORMATTED_NUM}_${FORMATTED_NAME}.${EXT}"

# Check if file exists
if [ -f "$FILENAME" ]; then
    echo "----------------------------------------"
    echo "⚠️  WARNING: File '$FILENAME' already exists."
    read -p "Do you want to overwrite it? (y/n): " confirm
    if [[ $confirm != "y" ]]; then
        echo "Operation cancelled."
        exit 1
    fi
fi

# 3. Prompt for Metadata
echo ""
echo "--- Metadata for Header ---"
read -p "Rating (e.g. 1200): " RATING
read -p "Link: " LINK
read -p "Tags (comma separated): " TAGS
read -p "Initial Status (Press Enter for 'TODO REVIEW'): " STATUS

# Set default status if empty
if [ -z "$STATUS" ]; then
    STATUS="TODO REVIEW"
fi

# 4. Generate the File
cat <<EOF > "$FILENAME"
$COMMENT_START
--------------------------------------------------------------------------
PROBLEM:      $PROBLEM_NUM. $PROBLEM_NAME_INPUT
RATING:       $RATING
LINK:         $LINK
--------------------------------------------------------------------------
STATUS:       $STATUS
TAGS:         $TAGS
--------------------------------------------------------------------------
POST-MATCH ANALYSIS:
1. Observations:
   - 

2. Mistakes / "Whiffs":
   - 

3. Complexity:
   - Time: O()
   - Space: O()
--------------------------------------------------------------------------
$COMMENT_END

$CLASS_STUB
EOF

echo "----------------------------------------"
echo "✅ Success! File created:"
echo "   $FILENAME"
echo "----------------------------------------"