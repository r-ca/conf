export SCRIPT_DIR="$HOME/custom_scripts/scripts"
export NANOKA_SCRIPT_PATH="$HOME/custom_scripts/bin/nanoka.sh"
fpath=( "$HOME/custom_scripts/completion" "${fpath[@]}" )
alias nanoka="$NANOKA_SCRIPT_PATH"
compdef _nanoka $NANOKA_SCRIPT_PATH
