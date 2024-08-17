#!/bin/sh
# shellcheck disable=2142

_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

if command -v diff-so-fancy >/dev/null 2>/dev/null
then
	# FIX: clipboard doesn't exist
	git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@" |
		fzf --no-sort --reverse --tiebreak=index --no-multi \
		--ansi --preview="$_viewGitLogLine" \
		--header "enter to view, alt-y to copy hash" \
		--bind "enter:execute:$_viewGitLogLine   | less -R" \
		--bind "alt-y:execute:$_gitLogLineToHash | clipboard"

else
	git log --graph --color=always \
		--format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
		fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
		--bind "ctrl-m:execute:
			(grep -o '[a-f0-9]\{7\}' | head -1 |
				xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
							{}
							FZF-EOF"
fi
