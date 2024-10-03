#!/bin/sh
set -e

usage() {
	echo "Usage: $0 <basepath>" >&2
	exit 1
}

if [ "$#" -ne 1 ]
then
	usage
fi

basepath="$1"

find "$basepath" -type d \( -name cur -o -name new \) \( \! -empty \) -printf '%h\n' \
	| sort --unique \
	| while IFS= read -r mailpath
do
	boxname=$(expr "$mailpath" : "$basepath/\(.*\)")

	[ -n "$boxname" ] && printf '"%s" "%s"\n' "$boxname" "$mailpath"
done
