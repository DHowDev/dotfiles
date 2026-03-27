# --- Personal zshrc (VPS) ---
[ -f /etc/zshrc ] && . /etc/zshrc

PROMPT='%n@%m:%~%# '

HISTSIZE=5000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS HIST_APPEND INC_APPEND_HISTORY

setopt autocd

bindkey -v

alias l='ls -CF'
alias g='git'
alias v='nvim || vim || vi'

alias claudeauto="claude --dangerously-skip-permissions"

# Colors for ls
export LS_COLORS="di=1;36:ln=36:so=35:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
alias ls='ls --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -lah --color=auto'

# Colored grep
alias grep='grep --color=auto'

# Prompt
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# Machine-local overrides (not tracked in git)
[ -f ~/.zshrc.local ] && . ~/.zshrc.local
