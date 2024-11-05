# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# Plugins
autoload -Uz compinit && compinit

zinit light zsh-users/zsh-autosuggestions # Suggest
zinit light zsh-users/zsh-syntax-highlighting # 構文ハイライト
zinit light chrissicool/zsh-bash # bash-like な挙動にする
zinit light pavoljuhas/smart-change-directory # scdを追加

# Other
setopt AUTO_PARAM_KEYS
setopt PROMPT_SUBST # 毎回プロンプトを再評価

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -Uz add-zsh-hook
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

export LANG=en_US.UTF-8 # 言語設定
