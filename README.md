# MZD's shell profile

It's how I like it, your mileage may vary.

Mostly, this is a collection of bash functions I have accreted. 

Specific install steps at end of this document.

## Alias Definitions

To keep order in my shell aliases, I wanted to put them in discrete files. So, the `.rcd` directory is meant to just hold includes to be sourced by `.bashrc`/`.zshrc`.

```bash

#
# Auto-load shell resource files from .rcd
if [ -d ~/.rcd ]; then
	for f in ~/.rcd/*
	do
		if [ -f "$f" ]; then
			. "$f"
		fi
	done
fi
```

If you add the above to your `...rc` file, you will get most of the benefits of this repo.

## Custom Prompt

Just for fun, I define a custom prompt. There are some other examples commented-out in `.bashrc`, so play with it.

See the `PS1=` definitions.

## Navigating Dirs

I can't believe how many years I went without learning the `pushd/popd` shell built-ins. People have come up with pretty complicated solutions to navigating the directory structure.

See `help` for `pushd`, `popd`, and `dirs` for an introduction to the built-ins. 

TL;DR - Navigate directories by "pushing" onto a stack, or ring. Rotate the ring, or pop-off entries (and change to the new top of the stack). NB: the "top" is index 0, another peculiarity of `pushd`, IMO.

I have drastically customized the builtins to make them more intuitive, to me. In particular, I was confused about using indexes. "Rotating" the stack works intuitively with indexes. Rotating `+1`, makes the entry at index-1 the top of the stack. 

But rotating `-1` broke my brain, because it is a zero-based index, not a number of positions. The `dir-stack` wrapper of `pushd`, ***subtracts 1 from reverse-indexes***, so `-1` references the last index in the stack, instead of the second-to-last index. You can also use `nxt` and `prv` as aliases for `pushd +1` and `pushd -0`, respectively. 

The stack is displayed in reverse so the current index is most-near to the new command prompt line. Note that index 0 is the actual "top" of the stack, which is the "current" directory and where new paths are added.

The core wrapper of `pushd` is `dir-stack`, short-form: `pd`, which does:
 * de-dupes the stack and de-references links
 * `-c` clears the stack
 * adds one or more directories to the stack (also works with `-c`)
 * advances to the next directory if no arguments are passed
 * advances to the index passed (no `+` needed, but optional)
 * reverses to a negative index passed (subtracting one first, see above)
 * displays the stack with indexes (calls `dir-index`)

All of the commands are wrappers for the `dir-stack` command, but alter the output and default arguments.

Instead of outputting the current stack, `nxt` and `prv` output the contents of the new directory.

Instead of defaulting to advancing one, `load-dirs` loads all of the directories in the current directory.

#### Commands

* `dir-index`/`dix` lists the directory stack with indexes
* `dir-stack`/`pd` push a directory or move to an index in the stack (`+` is optional, `-` reverses direction)
* `nxt`/`nx` advance the stack and display contents
* `prv`/`pv` reverse the stack and display contents
* `load-dirs` defaults to adding all of the directories in the current directory (and clearing the previous stack).
* `popd` is still used to remove the top of the stack

#### Example 
A typical use-case, using short-aliases, could be:

``` bash
# initialize the stack. (output is same as dir-index/dix)
# note that ToDo/ is de-referenced to the canonical path
 mzd@penguin: ~> pd Documents Lab/website/ ToDo
 3  ~
 2  ~/Documents
 1  ~/Lab/website
 0  ~/Documents/ToDo/projects/active
 
# advance to index 1
# the new stack state is displayed
mzd@penguin: ~/Documents/ToDo/projects/active> pd 1
 3  ~/Documents/ToDo/projects/active
 2  ~
 1  ~/Documents
 0  ~/Lab/website

# go-back. (new dir contents are displayed in a custom format)
mzd@penguin: ~/website> pv
 -   /home/mzd/Documents/ToDo/projects/active  - 
.
├── assets
├── ACTIONS.md
├── Admin.md
├── ERRANDS.md
├── EXPEDITE.md
...
└── Website.md

2 directories, 14 files

```

> **Bonus:** I recommend you install the `tree` command. This repo contains aliases for `ld` and `lld` to list 2 or 3 levels (respectively) of directories in a formatted tree. The `pushd` wrapper uses `tree` to display contents, but can default to `ls`.

## Crypto

#### SSH-keys

This file contains utils motivated by the need to ease working with ssh keys based on fingerprints.

use the source, Luke.

#### GPG-Keys

A little guidance for basic GPG key operations. Especially, clearly getting Key ID's and Fingerprints since the regular output doesn't make ID's clear. Required arguments are passed via env, and validation will tell you what is missing. 

Most functions are prefixed with `gpg-`, so you can discover them with completion. One exception is `git-configure-signing()` which is just a friendly wrapper around `git config --global` to set your signing-key.

## SSH

This is just my SSH config file, but the configs in the beginning may be of general interest.

## Git Config

Use the `configure-git.sh` script to set git global configs with prompts and defaults that I like.

It will recommend and point you to the functions to configure commit signing (create a key, and update your global config).

## Docker Aliases

I'm quite fond of these. See them in the `.rcd/devtools` file. Most start with "dk".

# Setup

I have not tried deploying the `.bashrc` file contents to Zsh, let me know how it goes! 

Clone this repo to `~/.dot-profile` (or whatever you want).

You can look for dependencies and recommendations with the included `./system-chk.sh` script. If you run it with verbose (`-v`) it will print positive confirmation in addition to checks that fail. You may decide whether to resolve the failed checks or not.

A full setup looks like the following, but you should pick and choose.

```bash
# see what is missing
 $> source system-chk.sh

# install aliases and custom prompt
 $> ln -s .dot-profile/.rcd
 $> ln -s .dot-profile/.bashrc

# use ssh config
 $> ln -s .dot-profile/ssh_config ~/.ssh/config

# configure git with prompts
 $> .dot-profile/configure-git.sh

# generate a new signing key
 $> gpg-generate-signing-key USER_NAME='Tenex Dev' EMAIL=you@domain.com

# get the new key ID
 $> gpg-list-key-ids

# enable signed commits
 $> configure-git-signing KEY_ID=<the-key-id> 
```