#!/bin/bash

# Script directory
# SCRIPT_DIR="$HOME/scripts" Provide at environment variable

# Show help message
show_help() {
    echo "Usage: run_script <command> [script] [args...]"
    echo
    echo "Commands:"
    echo "  list          List available scripts"
    echo "  run <script>  Run a script with optional arguments"
    exit 0
}

# List available scripts
list_scripts() {
    echo "Available scripts:"
    for script in "$SCRIPT_DIR"/*.sh; do
        [ -e "$script" ] || continue
        script_name=$(basename "$script")
        description=$(grep "^# Description:" "$script" | cut -d':' -f2- | sed 's/^ //')
        echo "- ${script_name}: ${description:-No description available}"
    done
}

# Run a script
run_script() {
    local script_name="$1"
    shift
    local script_path="$SCRIPT_DIR/$script_name"

    if [ ! -x "$script_path" ]; then
        echo "Error: Script '$script_name' not found or not executable."
        exit 1
    fi

    "$script_path" "$@"
}

# Argument validation
if [ $# -lt 1 ]; then
    show_help
fi

COMMAND="$1"
shift

case "$COMMAND" in
    list)
        list_scripts
        ;;
    run)
        if [ $# -lt 1 ]; then
            echo "Error: Missing script name."
            show_help
        fi
        run_script "$@"
        ;;
    *)
        echo "Error: Unknown command '$COMMAND'."
        show_help
        ;;
esac
