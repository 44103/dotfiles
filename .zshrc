#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
LS_COLORS="${LS_COLORS}:ow=02;34"; export LS_COLORS

bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line

re-prompt() {
    zle .reset-prompt
    zle .accept-line
}
zle -N accept-line re-prompt

setopt multios
setopt prompt_subst
setopt hist_reduce_blanks
setopt nolistbeep
