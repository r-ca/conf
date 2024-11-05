source $ZSH_D/prompt/_common.zsh
if [ "$rca_shell_prompt_mode" = "normal" ]; then
    source $ZSH_D/prompt/sonanoka.zsh
elif [ "$rca_shell_prompt_mode" = "presentation" ]; then
    source $ZSH_D/prompt/nanoka.zsh
elif [ "$rca_shell_prompt_mode" = "nyashi" ]; then
    source $ZSH_D/prompt/nyashi.zsh
else
    # Warning
    echo "Unknown/Invalid/Unset prompt mode: $rca_shell_prompt_mode"
    source $ZSH_D/prompt/sonanoka.zsh
fi

export PROMPT='$(left-prompt)'
