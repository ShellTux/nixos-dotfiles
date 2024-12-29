#!/bin/sh
set -e

usage() {
    printf 'Usage: %s <file> [...]\n' "$(basename "$0")"
    echo
    echo 'Flags:'
    echo '   -h, --help'
    echo '   -v, --verbose'
    exit 1
}

verbose=false

for arg
do
    if [ "$arg" = -v ] || [ "$arg" = --verbose ]
    then
        verbose=true
    fi

    if [ "$arg" = -h ] || [ "$arg" = --help ]
    then
        usage
    fi
done

for arg
do
	file="$arg"
        test -f "$file" || continue

	mkdir --parents "$(dirname "$file")"
        $verbose && echo touch "$file"
	touch "$file"
done
