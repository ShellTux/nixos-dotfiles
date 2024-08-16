#!/bin/sh
set -e

if [ "$#" -eq 0 ]
then
	fzf \
		--preview='bat --color=always --style=numbers {}' \
		--bind='enter:execute(bat --paging=always {})+clear-query' \
		--preview-window=right:70%
else
	# shellcheck disable=SC2068
	find $@ -type f | fzf \
		--preview='bat --color=always --style=numbers {}' \
		--bind='enter:execute(bat --paging=always {})+clear-query' \
		--preview-window=right:70%
fi
