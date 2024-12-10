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

# Utils
source "$ZSH_D/utils.zsh"

# OS/Arch specific
# source "$ZSH_D/alias/alias_macos.zsh"
# source "$ZSH_D/common/macos.zsh"

# add_to_path "$HOME/bin"

export VOLTA_HOME="$HOME/.volta"
add_to_path "$VOLTA_HOME/bin"

add_to_path "$HOME/.cargo/bin"

export PYENV_HOME="$HOME/.pyenv"
add_to_path "$PYENV_HOME/bin"

eval "$(pyenv init -)"

add_to_path "/usr/local/cuda-12.4/bin"
