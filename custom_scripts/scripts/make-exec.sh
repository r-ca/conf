#!/bin/bash
# Description: Make all .sh files in the scripts directory executable

# Ensure SCRIPT_DIR is set (inheriting from the parent nanoka script or environment)
: "${SCRIPT_DIR:?Environment variable SCRIPT_DIR is not set.}"

echo "Applying executable permissions to scripts in: $SCRIPT_DIR"

count=0

# Iterate over all .sh files in the directory
for script in "$SCRIPT_DIR"/*.sh; do
    # Check if the file actually exists (handles cases where no .sh files exist)
    if [[ -f "$script" ]]; then
        chmod +x "$script"
        echo "  [OK] $(basename "$script")"
        ((count++))
    fi
done

echo -e "\n✨ Successfully made $count script(s) executable."
