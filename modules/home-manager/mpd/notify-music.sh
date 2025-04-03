#!/bin/sh

usage() {
	echo "Usage: $(basename "$0") [-h|--help] [-q|--quiet] [-n|--no-notification]"
	echo
	echo "Options:"
	echo "  -h, --help               Show usage page"
	echo "  -q, --quiet              Supress message echoing"
	echo "  -n, --no-notification    Disable desktop notification"

	exit 2
}

quiet=false
notification=true
cover=/tmp/mpd-cover.png

TEMP=$(getopt \
	--options 'hnq' \
	--long 'help,no-notification,quiet' \
	--name "$(basename "$0")" -- "$@")

# shellcheck disable=SC2181
if [ $? -ne 0 ]; then
	echo 'Terminating...' >&2
	exit 1
fi

# Note the quotes around "$TEMP": they are essential!
eval set -- "$TEMP"
unset TEMP

while true
do
	case "$1" in
		-h | --help)
			usage
			;;
		-q | --quiet)
			quiet=true
			shift
			continue
			;;
		-n | --no-notification)
			notification=false
			shift
			continue
			;;
		--)
			shift
			break
			;;
		*) # Option not dealt with
			echo 'Internal error!' >&2
			exit 1
			;;
	esac
done

progress="$(mpc status | awk 'NR==2 { gsub(/[(%)]/,""); print $4 }')"
message="$(mpc status \
	| sed '2s/playing/  /;2s/paused/  /' \
	| sed '3s/ off */    /g;3s/ on */    /g;3s/ \{3\}/ \n/g')

$(mpc stats)"

$quiet || echo "$message"

appName="$(basename "$0")"
msgTag='music'
$notification && notify-send 'MPD' "$message" \
	--app-name="$appName" \
	--hint=int:value:"$progress" \
	--hint=string:x-dunst-stack-tag:"$msgTag" \
	--icon="$cover" \
	--urgency=low \
	--replace-id=1061 # FIX: https://github.com/dunst-project/dunst/issues/1061
