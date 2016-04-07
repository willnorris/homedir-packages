# Ignore commands that begin with '#'
set -k

# Autoload zsh functions.
fpath+="$HOME/.zsh/completion"

autoload -U compinit && compinit

zstyle ':completion:*' menu select=2

# use vi key bindings
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey "^?" backward-delete-char

# sane backspace behavior
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char


# History
setopt hist_expire_dups_first hist_ignore_space hist_no_functions \
  hist_no_store inc_append_history share_history
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history


# Alias common commands to begin with a space so they don't appear in zsh
# history.  This is the closest I can come to Bash's HISTIGNORE setting
for c (fg bg jobs exit clear reset); do
  alias $c=" $c"
done

# TODO: eliminate the need for these host-specific configs or move to rvm
local file="${HOME}/.zsh/host/${SHORT_HOST}"
[[ -r ${file} ]] && source ${file}

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


alias vi=vim
export EDITOR='vim'
export VISUAL=${EDITOR}
export PAGER='less'
export LYNX_LSS=${HOME}/.lynx.lss

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
source $HOME/.zsh/bundle/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh