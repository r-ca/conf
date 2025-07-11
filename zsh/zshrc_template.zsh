# path
export ZSH_D=$HOME/.zsh.d

# Set prompt
if [ -z "$rca_shell_prompt_mode" ]; then
    export rca_shell_prompt_mode=normal
fi

# Common
source "$ZSH_D/bootstrap.zsh"
source "$ZSH_D/configs.zsh"
source "$ZSH_D/prompt/index.zsh"
source "$ZSH_D/alias/alias_common.zsh"
source "$ZSH_D/alias/alias_mark.zsh"

# Utils
source "$ZSH_D/utils/add_to_path.zsh"
source "$ZSH_D/utils/mark.zsh"

# OS/Arch specific
source "$ZSH_D/alias/alias_macos.zsh"
source "$ZSH_D/common/macos.zsh"

add_to_path "$HOME/bin"


# -- Run finally.zsh at the end of zshrc --
source "$ZSH_D/finally.zsh"

source "$ZSH_D/common/run-nanoka.zsh" # use compdef in this script, so load after compinit
