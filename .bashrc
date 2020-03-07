# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [[ -z "${debian_chroot:-}" ]] && [[ -r /etc/debian_chroot ]]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [[ -f ~/.bash_aliases ]]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [[ -f /usr/share/bash-completion/bash_completion ]]; then
        . /usr/share/bash-completion/bash_completion
    elif [[ -f /etc/bash_completion ]]; then
        . /etc/bash_completion
    fi
fi

if [[ -d "$HOME/.local/bin" ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [[ "`tty`" == /dev/tty* || ${SHLVL} -eq 2 ]]; then
    export TERM=fbterm
    if [[ ${SHLVL} -eq 1 ]]; then
        ((SHLVL+=1)); export SHLVL
        exec fbterm "$@"
    fi
fi

if [[ -z "$SSH_CLIENT" ]] || [[ -z "$SSH_TTY" ]]; then
	if [[ -z "$TMUX" ]]; then
		case ${TERM} in
			fbterm|screen*)
				tmux attach -t $(basename $(tty)) || tmux new -s $(basename $(tty))
			;;
		esac
	fi
fi

export POWERLINE_COMMAND=powerline
export POWERLINE_CONFIG_COMMAND=powerline-config

if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
fi
