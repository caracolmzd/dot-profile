#!/bin/bash

###
# Include local customizations
if [ -f ~/.bash_alias_local ]
then
	# shellcheck source=/dev/null
	. ~/.bash_alias_local
fi

if [ -d ~/.bash_aliases_local ]; then
	for f in ~/.bash_aliases_local/*
	do
		if [ -f "$f" ]; then
			. "$f"
		fi
	done
fi
