#!/bin/bash

# Ensure SCRIPT_DIR is set via an environment variable
: "${SCRIPT_DIR:?Environment variable SCRIPT_DIR is not set. Please set it to the scripts directory.}"

# Show help message
show_help() {
    echo "Usage:"
    echo "  nanoka list"
    echo "  nanoka run <script> [args...]"
    echo "  nanoka <script> [args...]"
    echo "  nanoka add <script> <command...>"
    echo
    echo "Commands:"
    echo "  list          List available scripts"
    echo "  run <script>  Run a script with optional arguments"
    echo "  <script>      Run a created script directly"
    echo "  add <script>  Register a new script quickly from a command"
    echo "  help          Show this help message"
    exit 0
}

normalize_script_name() {
    local script_name="$1"

    if [[ "$script_name" != *.sh ]]; then
        script_name="${script_name}.sh"
    fi

    if [[ ! "$script_name" =~ ^[A-Za-z0-9._-]+\.sh$ ]]; then
        echo "Error: Invalid script name '$1'. Use only letters, numbers, ., _, -."
        exit 1
    fi

    printf '%s\n' "$script_name"
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
    local script_name
    script_name="$(normalize_script_name "$1")"
    shift

    local script_path="$SCRIPT_DIR/$script_name"

    if [ ! -x "$script_path" ]; then
        echo "Error: Script '$script_name' not found or not executable."
        exit 1
    fi

    "$script_path" "$@"
}

add_script() {
    local raw_name="$1"
    shift

    if [ -z "$raw_name" ] || [ $# -lt 1 ]; then
        echo "Error: Missing script name or command."
        echo "Usage: nanoka add <script> <command...>"
        exit 1
    fi

    local script_name
    script_name="$(normalize_script_name "$raw_name")"
    local script_path="$SCRIPT_DIR/$script_name"

    if [ -e "$script_path" ]; then
        echo "Error: Script '$script_name' already exists."
        exit 1
    fi

    local escaped_command
    escaped_command="$(printf '%q ' "$@")"
    escaped_command="${escaped_command%" "}"

    cat > "$script_path" <<EOF
#!/bin/bash
# Description: $raw_name command
# Options:

$escaped_command
EOF

    chmod +x "$script_path"
    echo "Created: $script_path"
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
    add)
        add_script "$@"
        ;;
    help)
        show_help
        ;;
    *)
        run_script "$COMMAND" "$@"
        ;;
esac
