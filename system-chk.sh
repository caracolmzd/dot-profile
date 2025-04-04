#!/bin/bash

# # #
echo  "   - Utility to check for dependencies and recommended commands. -"
echo  "     Usage: ./system-chk.sh [-v]"
# # #

# check for type of shell, sh, dash, bash or zsh:
echo ""
if [ -n "$SH_VERSION" ]; then
	echo "POSIX shell detected."
elif [ -n "$DASH_VERSION" ]; then
	echo "Dash shell detected."
elif [ -n "$BASH_VERSION" ]; then
	echo "Bash shell detected."
elif [ -n "$ZSH_VERSION" ]; then
	echo "Zsh shell detected."
else
	echo "Shell not recognized."
fi
echo ""

# check if verbose (-v) was passed.
if [ "$1" == "-v" ]; then
	verbose=true
else
	verbose=false
fi

verbose_print() {
	if [ "$verbose" = true ]; then
		echo "$1"
	fi
}

# 
# List of commands to check for in nowdoc
depends="
complete
docker
fzf
git
gpg
curl
make
nano
pandoc
pushd
ssh
ssh-keygen
tree
vim
w3m
wget
xclip
xdg-open
"

# check for dependencies
for cmd in $depends; do
	verbose_print "Check for $cmd..."
	if ! command -v $cmd > /dev/null; then
		echo "[x] ...Command not found: $cmd"
	fi
done

# check whether these utils are deployed (links exist).

# check if ~/.bashrc exists and is a link.
if [ -f ~/.bashrc ]; then
	if [ -L ~/.bashrc ]; then
		echo "~/.bashrc is a link -> " $(readlink -f ~/.bashrc)
	else
		echo "[x] ~/.bashrc is not a link."
	fi
else
	echo "[x] ~/.bashrc does not exist."
fi

# check if ~/.zshrc exists and is a link.
if [ -f ~/.zshrc ]; then
	if [ -L ~/.zshrc ]; then
		echo "~/.zshrc is a link -> " $(readlink -f ~/.zshrc)
	else
		echo "[x] ~/.zshrc is not a link."
	fi
else
	echo "[x] ~/.zshrc does not exist."
fi

# check if bash_completions is installed.
if [ -f /usr/share/bash-completion/bash_completion ]; then
	verbose_print "bash_completions is installed."
else
	echo "[x] bash_completions is not installed."
fi

# check if ~/.rc.d exists and is a link.
if [ -d ~/.rc.d ]; then
	if [ -L ~/.rc.d ]; then
		echo "~/.rc.d is a link -> " $(readlink -f ~/.rc.d)
	else
		echo "[x] ~/.rc.d is not a link."
	fi
else
	echo "[x] ~/.rc.d does not exist."
fi

# check if ~/.env.d exists and is a link.
if [ -d ~/.env.d ]; then
	if [ -L ~/.env.d ]; then
		echo "~/.env.d is a link -> " $(readlink -f ~/.env.d)
	else
		echo "[x] ~/.env.d is not a link."
	fi
else
	echo "[x] ~/.env.d does not exist."
fi

# check if ~.ssh/config exists and is a link.
if [ -f ~/.ssh/config ]; then
	if [ -L ~/.ssh/config ]; then
		echo "~/.ssh/config is a link -> " $(readlink -f ~/.ssh/config)
	else
		echo "[x] ~/.ssh/config is not a link."
	fi
else
	echo "[x] ~/.ssh/config does not exist."
fi

# check if ~/.vim exists and is a link.
if [ -d ~/.vim ]; then
	if [ -L ~/.vim ]; then
		echo "~/.vim is a link -> " $(readlink -f ~/.vim)
	else
		echo "[x] ~/.vim is not a link."
	fi
else
	echo "[x] ~/.vim does not exist."
fi

# check if ~/.vimrc exists and is a link.
if [ -f ~/.vimrc ]; then
	if [ -L ~/.vimrc ]; then
		echo "~/.vimrc is a link -> " $(readlink -f ~/.vimrc)
	else
		echo "[x] ~/.vimrc is not a link."
	fi
else
	echo "[x] ~/.vimrc does not exist."
fi

if command -v git > /dev/null; then
	verbose_print ""
	verbose_print " - Git global configuration: -"
	GIT_CONFIG_LIST=$(git config --list --global)
	verbose_print "$GIT_CONFIG_LIST"
fi
