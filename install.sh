#!/bin/bash

# get location of this file
# source_dir = ...

# detect bash or zsh

# ask to use hardlinks or softlinks

# set rc file to .bashrc or .zshrc

# change to HOME
# pushd $HOME

# define prompt for confirmation and use for each...

# define install method
# auto-detect installation of dir or file
# use use soft-links unless is-file && user-confirmed

# install .rcd

# install .bashrc or .zshrc

# install .ssh/config

# install .gitconfig

# Final install should look like:
# ll | grep dot-profile
# drwxrwxr-x  4 mzd  mzd  4.0K Jun  5 22:14 .dot-profile/
# lrwxrwxrwx  1 mzd  mzd    17 Jun  5 22:11 .rcd -> .dot-profile/.rcd/
# lrwxrwxrwx  1 mzd  mzd    20 Jun  5 22:10 .bashrc -> .dot-profile/.bashrc
# lrwxrwxrwx  1 mzd  mzd    27 Jun  5 20:24 .gitconfig -> .dot-profile/.gitconfig-mzd
# lrwxrwxrwx  1 mzd  mzd    24 Jun  5 21:56 .ssh_config -> .dot-profile/.ssh_config




