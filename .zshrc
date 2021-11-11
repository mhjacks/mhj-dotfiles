# History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt prompt_subst
setopt share_history # share command history data

umask 022

# Add to function path
fpath=(~/.zsh_functions $fpath)

autoload -Uz pathmunge
autoload -Uz kubeconfig_on
autoload -Uz kubeconfig_off
autoload -Uz kubeconfig_status

autoload -Uz compinit
compinit

# Turn on colors
autoload -Uz colors
colors


# Prompt - themed
# influence __git_ps1 output
#export GIT_PS1_SHOWUPSTREAM="auto verbose name git"
GIT_PS1_SHOWUPSTREAM=(verbose name)
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1

autoload -Uz promptinit
promptinit
prompt adam1git

# Enable built-in FTP client
#autoload -Uz zfinit
#zfinit

# Enable zcalc
autoload -Uz zcalc

# Z-versions of standard utils
# zcp and zln are implemented as command line args to zmv
# autoloading them doesn't work
autoload -Uz zmv
alias zcp='zmv -C'
alias zln='zmv -L'

# The Z editor
autoload -Uz zed

# Vi-mode by default
bindkey -v
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Set xterm titles
case $TERM in
        xterm*|rxvt*|roxterm*)
                xterm_preexec () {
                        print -Pn "\e]0;%n@%m:%~: $1\a"
                }

		add-zsh-hook preexec xterm_preexec
        ;;
esac

# Aliases
alias d2b='perl -e '\''printf qq|%b\n|, int( shift )'\'''
alias d2h='perl -e '\''printf qq|%X\n|, int( shift )'\'''
alias d2o='perl -e '\''printf qq|%o\n|, int( shift )'\'''
alias h2b='perl -e '\''printf qq|%b\n|, hex( shift )'\'''
alias h2d='perl -e '\''printf qq|%d\n|, hex( shift )'\'''
alias h2o='perl -e '\''printf qq|%o\n|, hex( shift )'\'''
alias o2b='perl -e '\''printf qq|%b\n|, oct( shift )'\'''
alias o2d='perl -e '\''printf qq|%d\n|, oct( shift )'\'''
alias o2h='perl -e '\''printf qq|%X\n|, oct( shift )'\'''

# Colorization and aliases
alias ls='ls --color=auto'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

alias l='ls -CF'
alias la='ls -A'
alias ll='ls -l'
#alias vim=nvim
alias vi=vim

# Path manipulation
path=(~/.local/bin ~/bin $path /usr/games)

# Exports
export EDITOR=vim
export PATH

# Default is dark blue, which doesn't show well in the dark
# we can override later in .zshrc_local if needed
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[globbing]=fg=magenta,bold

if [ -f ~/.zshrc_local ]; then
    . ~/.zshrc_local
fi

# ZSH magic to dedupe path
typeset -U PATH path

# Include syntax highlighting if present
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
