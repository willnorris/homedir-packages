# Ignore commands that begin with '#'
set -k

# Keep lots of shell history and save it to ~/.zsh_history
setopt hist_expire_dups_first hist_ignore_space hist_no_functions \
  hist_no_store inc_append_history share_history
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

# Autoload zsh functions.
fpath+="$HOME/.zsh/completion"

zstyle ':completion:*' menu select=2

# use vi key bindings
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey "^?" backward-delete-char

# sane backspace behavior
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char

# Alias common commands to begin with a space so they don't appear in zsh
# history.  This is the closest I can come to Bash's HISTIGNORE setting
for c (fg bg jobs exit clear reset); do
  alias $c=" $c"
done

if [[ -d "$HOME/.zsh/bundle/zsh-syntax-highlighting" ]]; then
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
  source $HOME/.zsh/bundle/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
if (( $+ZSH_HIGHLIGHT_STYLES )); then
  ZSH_HIGHLIGHT_STYLES[comment]=fg=yellow,bold
fi
