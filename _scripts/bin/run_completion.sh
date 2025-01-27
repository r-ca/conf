#compdef nyashi

_nyashi() {
    local commands=("list" "run" "help")
    local scripts
    scripts=($(ls "$HOME/scripts"/*.sh 2>/dev/null | xargs -n 1 basename | sed 's/\.sh$//'))

    _arguments \
        '1:command:(list run help)' \
        '2:script_name:($(echo $scripts | tr " " "\n"))' \
        '*::arguments:'

}

_nyashi "$@"
