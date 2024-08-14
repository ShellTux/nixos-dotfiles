#!/bin/sh
set -e

usage() {
	echo "$(basename "$0") <package>"
	echo
	echo "Example:"
	echo "$(basename "$0") wl-clipboard"
	exit 1
}

[ "$#" -lt 1 ] && usage

nixpath="$(nix build "nixpkgs#$1" --print-out-paths --no-link)"
eza \
	--color=auto \
	--color-scale all \
	--icons \
	--tree \
	--git-ignore \
	"$nixpath"
