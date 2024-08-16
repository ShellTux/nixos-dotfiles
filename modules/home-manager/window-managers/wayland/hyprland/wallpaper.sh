#!/bin/sh
set -e

BASENAME="$(basename "$0")"
WALLPAPER_LOCK="/tmp/$BASENAME.lock"
WALLPAPER_HOMEDIR="${WALLPAPER_HOMEDIR:-$HOME/Wallpapers/Imagens}"
INTERVAL_SECONDS=600

usage() {
	echo "$BASENAME <subcommand>"
	echo
	echo "List of subcommands:"
	echo "- daemon"
	echo "- next"
	echo "- img <image path>"

	exit 1
}

random_wallpaper() {
	# shellcheck disable=SC2086
	find $WALLPAPER_HOMEDIR -type f | shuf --head-count=1
}

update_wallpaper() {
	img="$(random_wallpaper)"
	swww img --transition-type=random "$img"
}

daemon_wallpaper() {
	if [ -f "$WALLPAPER_LOCK" ]
	then
		echo "lock file is present ($WALLPAPER_LOCK), Do you have another instance running? If not you can manually delete it."
		exit 1
	fi
	
	echo "$$" > "$WALLPAPER_LOCK"
	daemon_signals

	swww-daemon --format xrgb &

	(
	while true
	do
		[ ! -f "$WALLPAPER_LOCK" ] && exit
		update_wallpaper
		sleep "$INTERVAL_SECONDS" || true
	done
	)

	daemon_exit
	exit 0
}

daemon_exit() {
	rm "$WALLPAPER_LOCK"

	swww kill
}

#shellcheck disable=SC2317
daemon_SIGINT() {
	echo "SIGINT Received..."
	daemon_exit
}

#shellcheck disable=SC2317
daemon_SIGTERM() {
	echo "SIGTERM Received..."
	daemon_exit
}

daemon_signals() {
	trap 'daemon_exit' EXIT
	trap 'daemon_SIGINT' INT
	trap 'daemon_SIGTERM' TERM
}

next() {
	if [ ! -f "$WALLPAPER_LOCK" ]
	then
		echo "No instance of wallpaper daemon running!"
		echo
		echo "Tip: $BASENAME daemon"
		exit 1
	fi

	pkill --parent="$(pgrep --parent="$(head -1 "$WALLPAPER_LOCK")" "$BASENAME" | sort | tail -1)" sleep
	
	exit 0
}

[ "$#" -lt 1 ] && usage

case "$1" in
	daemon)
		daemon_signals
		daemon_wallpaper
		;;
	next) next ;;
esac

usage
