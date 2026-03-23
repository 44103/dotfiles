: ${GIT_AUTO_FETCH_INTERVAL:=0}
zmodload zsh/datetime
zmodload -F zsh/stat b:zstat

function git-fetch-all {
  (
    gitdir="$(command git rev-parse --git-dir 2>/dev/null)" || return 0
    [[ -w "$gitdir" && ! -f "$gitdir/NO_AUTO_FETCH" ]] || return 0
    lastrun="$(zstat +mtime "$gitdir/FETCH_LOG" 2>/dev/null || echo 0)"
    (( EPOCHSECONDS - lastrun < GIT_AUTO_FETCH_INTERVAL )) && return 0
    print -n &>! "$gitdir/FETCH_LOG"
    GIT_SSH_COMMAND="command ssh -o BatchMode=yes" \
      GIT_TERMINAL_PROMPT=0 \
      command git fetch --all 2>/dev/null &>> "$gitdir/FETCH_LOG"
  ) &|
}

(( ${+functions[_git_auto_fetch_zle_init]} )) && return 0
case "$widgets[zle-line-init]" in
  builtin|"") function _git_auto_fetch_zle_init { git-fetch-all } ;;
  user:*)
    zle -N _git_auto_fetch_orig_zle_init "${widgets[zle-line-init]#user:}"
    function _git_auto_fetch_zle_init { git-fetch-all; zle _git_auto_fetch_orig_zle_init -- "$@" } ;;
esac
zle -N zle-line-init _git_auto_fetch_zle_init
