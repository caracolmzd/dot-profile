# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#
# Customize the prompt
#

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then

    # Distro:
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

    # Custom 1
    # PS1="\n\[\033[35m\]\$(/bin/date +%F\ wk#%V\ dy#%j\ %a\ %_R) \[\033[1;34m\]\$(/usr/bin/tty | /bin/sed -e 's:/dev/::'): \[\033[1;36m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files \[\033[1;33m\]\$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\033[0m\] \n\[\033[1;31m\]\u☯ \h: \[\033[32m\]\w>\[\033[0m\]"

    # Custom 2
    # PS1="\[\033[32m\]\w\[\033[00m\]\n\[\033[35m\]\$(/bin/date +%F\ wk#%V\ dy#%j\ %a\ %_R) \[\033[1;34m\]\$(/usr/bin/tty | /bin/sed -e 's:/dev/::'): \[\033[1;36m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files \[\033[1;33m\]\$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\033[0m\] \[\033[1;31m\] \n\u☯ \h: >\[\033[00m\]"

    # Custom 3
    PS1="\n\[\033[35m\]\$(/bin/date +%F\ %a\ %_R\ wk#%V\ dy#%j) \[\033[1;34m\]\$(/usr/bin/tty | /bin/sed -e 's:/dev/::'): \[\033[1;36m\] \[\033[1;31m\]\u☯ \h: \[\033[32m\]\w>\[\033[0m\]\n"

else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support in common commands
if [ -x /usr/bin/dircolors ]; then
    COLOR_AUTO='--color=auto'
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#
# Set a different default dir
#
#if [ $(pwd) == "$HOME" ]; then
#  pushd ~/Lab >/dev/null
#fi


#
# Aliases
#

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#
# Environment variables
if [ -d ~/.env.d ]; then
    for file in ~/.env.d/*
        do
            # ignore .tpl files and README and dot-files
            name=$(basename "$file")
            if [[ "$name" == *.tpl ]] \
                || [[ "$name" == *README ]] \
                || [[ "$name" == .* ]]
            then
                continue
            fi

            # Check if the file is a regular file (not a directory)
            if [ -f "$file" ]; then
                # Source the file to load the environment variables
                . "$file"

                # Export the variables
                export $(awk -F'=' '{print $1}' "$file") &>/dev/null
            fi
        done
fi  

#
# Auto-load shell resource files from .rcd
if [ -d ~/.rc.d ]; then
	for f in ~/.rc.d/*
	do
		if [ -f "$f" ]; then
			. "$f"
		fi
	done
fi
