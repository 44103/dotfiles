# Paths (unique)
export PNPM_HOME="$HOME/.local/share/pnpm"
typeset -gU cdpath fpath mailpath path
path=(
  "$HOME/.local/share/mise/shims"
  "$PNPM_HOME"
  "$HOME/.local/bin"
  "$HOME/bin"
  "$HOME/sbin"
  "/usr/local/bin"
  "/usr/local/sbin"
  $path
)

# Editors / Pager
export EDITOR="${EDITOR:-vi}"
export VISUAL="${VISUAL:-vi}"
export PAGER="${PAGER:-less}"

# Less options
export LESS='-g -i -M -R -S -w -X -z-4'

# sheldon (sources plugins including completions)
eval "$(sheldon source)"

# initialise completions with cache
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.m-1) ]]; then
  compinit -C
else
  compinit
fi

# completion settings (Prezto style)
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

# starship (use local config if available)
[[ -f ~/.config/starship.local.toml ]] && export STARSHIP_CONFIG=~/.config/starship.local.toml
eval "$(starship init zsh)"

# zsh settings
LS_COLORS="${LS_COLORS}:ow=02;34"; export LS_COLORS

bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line

# history-substring-search
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=blue,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

re-prompt() {
    zle .reset-prompt
    zle .accept-line
}
zle -N accept-line re-prompt

setopt multios
setopt prompt_subst
setopt hist_reduce_blanks
setopt nolistbeep
setopt pushd_ignore_dups
setopt extended_glob

# history settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_all_dups

# Load local configs (machine-specific, not tracked in git)
for f in ~/.dotfiles/local.d/*.sh(N); do source $f; done

