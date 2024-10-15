#!/bin/sh
set -e

export FZF_DEFAULT_OPTS='--preview="bat --color=always --style=numbers {}" --bind="enter:execute(bat --paging=always {})+clear-query" --preview-window=right:70%'

fd='fd --hidden --type file --type symlink'
for arg
do
	[ -d "$arg" ] && fd="$fd --search-path=$arg"
done

export FZF_DEFAULT_COMMAND="$fd"

# shellcheck disable=SC2068
fzf $@
