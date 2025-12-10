#!/bin/bash

echo "Git Global Configuration Setup"
echo "-------------------------------"

read -p "Enter your name: " name
read -p "Enter your email: " email

read -p "Set 'pull.rebase' [false|true|merges|interactive] (default: true): " rebase
rebase=${rebase:-true}

read -p "Set 'init.defaultBranch' (default: main): " defaultBranch
defaultBranch=${defaultBranch:-main}

read -p "Set 'core.editor' (default: vim): " editor
editor=${editor:-vim}

git config --global user.name "$name"
git config --global user.email "$email"
git config --global pull.rebase "$rebase"
git config --global init.defaultBranch "$defaultBranch"
git config --global core.editor "$editor"

echo "Git global configuration has been updated."

git config --global --list

echo "RECOMMENDED: run gpg-generate-signing-key() and git-configure-signing() to setup GPG signing of commits."
