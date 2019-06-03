if [ -d "$HOMEBREW_HOME/opt/fzf" ]; then
  export FZF_HOME="$HOMEBREW_HOME/opt/fzf"
fi

if [ -z "$FZF_HOME" ] && [ -d $HOME/.fzf ]; then
  export FZF_HOME=$HOME/.fzf
fi

if [ -n "$FZF_HOME" ]; then
  export PATH="$FZF_HOME/bin:$PATH"
fi

if command -v fzf > /dev/null; then
  if [ `command -v fd > /dev/null` ]; then
    export FZF_DEFAULT_COMMAND="fd --type file --hidden --follow --exclude .git --color always"
  fi
  export FZF_DEFAULT_OPTS="
  --color 16,fg+:-1,hl:1,hl+:1,info:2,marker:1 --no-bold --height '40%' --reverse
  --preview '(bat --color always {} 2> /dev/null || cat {} || tree -C -L 1 -F {}) 2> /dev/null | head -200'
  --bind '?:toggle-preview,alt-j:preview-down,alt-k:preview-up'
  --bind 'alt-space:preview-page-down,alt-f:preview-page-down,alt-b:preview-page-up'
  --bind 'ctrl-f:page-down,ctrl-b:page-up'
  "
  export FZF_CTRL_R_OPTS="--no-reverse"
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

  export FZF_TMUX=1

  # open recently edited files in vim (https://github.com/junegunn/fzf/wiki/Examples#v)
  v() {
    local files
    files=$(grep '^>' ~/.viminfo | cut -c3- |
            while read line; do
              [ -f "${line/\~/$HOME}" ] && echo "$line"
            done | fzf-tmux -d -m -q "$*" -1) && vim ${files//\~/$HOME}
  }

  # cd to recently opened directories (https://github.com/junegunn/fzf/wiki/Examples#z)
  j() {
    [ $# -gt 0 ] && _z "$*" && return
    cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf-tmux +s --tac --query "$*")"
  }

  # load or start named tmux session (https://github.com/bag-man/dotfiles/blob/c88cc45/bashrc)
  ts() {
    [ -n "$TMUX" ] && change="switch-client" || change="attach-session"
    if [ $1 ]; then
      tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
    fi
    session=$(command tmux list-sessions -F "#{session_name}" 2>/dev/null | \
      fzf --exit-0) && tmux $change -t "$session" || echo "No sessions found."
  }
fi
