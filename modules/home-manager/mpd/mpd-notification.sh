#!/bin/sh
set -e
set -o errexit
set -o nounset

cover=/tmp/mpd-cover.png

if [ "$(pgrep -f '^'"$(basename "$0")" | wc --lines)" -gt 2 ]
then
	printf 'Instance of %s already running\n' "$(basename "$0")"
	exit 1
fi

rm --force "$cover"

mpc idleloop player | while read -r _
do
	if ! pgrep '^mpd$' >/dev/null
	then
		printf 'No instance of %s running\n' 'mpd'
		exit 1
	fi

	ratio="$(mpc status '%percenttime%' | sed 's|%||')"

	music_file="$(xdg-user-dir MUSIC)/$(mpc --format %file% current)"

	# HACK: I will assume that when a track changes the percent time is less than
	# 5%, so I don't call ffmpeg needless when resuming a track
	if [ "$ratio" -le 5 ] || [ ! -f "$cover" ]
	then
		(
		set -x
		ffmpeg \
			-nostdin \
			-loglevel quiet \
			-y \
			-i "$music_file" \
			-an -vcodec copy "$cover"
		)
	fi
	notify-music --quiet
done
