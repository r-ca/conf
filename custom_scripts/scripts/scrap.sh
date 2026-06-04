#!/bin/bash
# Description: Dump the current directory to ~/scrapbox, or create a new scratchpad and jump in
# Options: -n

is_new=0
note=""

# Check for the -n option (new scratchpad mode)
if [[ "$1" == "-n" ]]; then
    is_new=1
    shift
fi

# --- Safety confirmation prompt ---
# Only prompt for confirmation if NOT in new scratchpad mode (-n)
if [[ $is_new -eq 0 ]]; then
    # Show a strong warning if executed in the HOME or ROOT directory
    if [[ "$PWD" == "$HOME" || "$PWD" == "/" ]]; then
        echo -e "\n🚨 WARNING: You are about to dump your ENTIRE $PWD directory!"
    fi

    # Abort if the input is not 'y' or 'Y'
    read -r -p "Proceed to dump '$PWD'? [y/N]: " response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 0
    fi
fi
# ----------------------------------

# Get the current timestamp in YYYYMMDD_HHMMSS format
timestamp=$(date +"%Y%m%d_%H%M%S")

# Determine the note (directory name suffix)
if [[ -n "$1" ]]; then
    note="$1"
else
    if [[ $is_new -eq 1 ]]; then
        note="scratch"
    else
        note="$(basename "$PWD")"
    fi
fi

dest="$HOME/scrapbox/${timestamp}_${note}"

# Create the destination directory
mkdir -p "$dest"

# Branch logic based on whether it's a new scratchpad or a directory dump
if [[ $is_new -eq 1 ]]; then
    echo -e "\n✨ Created empty scrap at: $dest"
else
    # Sync the current directory respecting .gitignore rules
    rsync -av --filter=':- .gitignore' . "$dest/"
    echo -e "\n🚀 Dumped current directory to: $dest"
fi

echo "Diving into sandbox... (type 'exit' to return)"

# Move to the target directory and spawn a subshell to keep the user there
cd "$dest" || exit 1
exec "${SHELL:-bash}"
