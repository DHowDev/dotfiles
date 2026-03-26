# --- Personal zshrc (VPS) ---
[ -f /etc/zshrc ] && . /etc/zshrc

PROMPT='%n@%m:%~%# '

HISTSIZE=5000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS HIST_APPEND INC_APPEND_HISTORY

setopt autocd

bindkey -v

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias g='git'
alias v='nvim || vim || vi'

alias claudeauto="claude --dangerously-skip-permissions"
