#!/bin/bash

# Prompt for file extension
read -p "File extension, e.g. 'php': " EXTENSION

# Exclude these directories; adjust as needed for given project
EXCLUDE_DIRS=("vendor" "node_modules" "lib" "admin")

# "or" path/prune statements together with `-o`
EXCLUDE_ARGS=()

for dir in "${EXCLUDE_DIRS[@]}"; do
    EXCLUDE_ARGS+=(-path "./$dir" -prune -o)
done

# Do it!
FILE_COUNT=$(find . "${EXCLUDE_ARGS[@]}" -type f -name "*.$EXTENSION" -print | wc -l)

echo "Total $EXTENSION files: $FILE_COUNT"

# Don't forget to bring a towel!
# And by that I mean `chmod +x` this.
