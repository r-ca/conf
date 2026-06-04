export SCRIPT_DIR="$HOME/custom_scripts/scripts"
export NANOKA_SCRIPT_PATH="$HOME/custom_scripts/bin/nanoka"
fpath=( "$HOME/custom_scripts/completion" "${fpath[@]}" )

autoload -Uz _nanoka

alias nanoka="$NANOKA_SCRIPT_PATH"
compdef _nanoka nanoka
