# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
        for rc in ~/.bashrc.d/*; do
                if [ -f "$rc" ]; then
                        . "$rc"
                fi
        done
fi

unset rc

# Get __git_ps1 for later prompt - or else stub it out
if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
        . /usr/share/git-core/contrib/completion/git-prompt.sh
else
    alias __git_ps1=/bin/true
fi

function pathmunge () {
    case ":${PATH}:" in
        *:"$1":*)
            ;;
        *)
            if [ "$2" = "after" ] ; then
                PATH=$PATH:$1
            else
                PATH=$1:$PATH
            fi
    esac
}

# Path management
pathmunge ~/bin
pathmunge ~/.local/bin

PROMPT_DIRTRIM=5

# Extra output for Git components
GIT_PS1_SHOWUPSTREAM="verbose name auto git"
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1

export EDITOR=vi
set -o vi
alias vi=vim

export HISTCONTROL=ignoredups:erasedups:ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize

PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"

alias ll='ls -l'

# other Aliases - conversions
alias d2b='perl -e '\''printf qq|%b\n|, int( shift )'\'''
alias d2h='perl -e '\''printf qq|%X\n|, int( shift )'\'''
alias d2o='perl -e '\''printf qq|%o\n|, int( shift )'\'''
alias h2b='perl -e '\''printf qq|%b\n|, hex( shift )'\'''
alias h2d='perl -e '\''printf qq|%d\n|, hex( shift )'\'''
alias h2o='perl -e '\''printf qq|%o\n|, hex( shift )'\'''
alias o2b='perl -e '\''printf qq|%b\n|, oct( shift )'\'''
alias o2d='perl -e '\''printf qq|%d\n|, oct( shift )'\'''
alias o2h='perl -e '\''printf qq|%X\n|, oct( shift )'\'''

# Default vte setting in /e/profile.d is reasonable
#PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
# Fancy prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[01;93m\]$(__git_ps1)\[\033[00m\]\n\$ '

#if [ -f `which powerline-daemon` ]; then
#  powerline-daemon -q
#  POWERLINE_BASH_CONTINUATION=1
#  POWERLINE_BASH_SELECT=1
#  . /usr/share/powerline/bash/powerline.sh
#fi
