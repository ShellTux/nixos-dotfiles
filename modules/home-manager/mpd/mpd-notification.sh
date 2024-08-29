#!/bin/sh
set -e
set -o errexit
set -o nounset

if [ "$(pgrep "$(basename "$0")" | wc --lines)" -gt 2 ]
then
	printf 'Instance of %s already running\n' "$(basename "$0")"
	exit 1
fi

COVER_FILEPATH=/tmp/cover.png
NOTIFICATION_URGENCY=low

notify() {
	progress="$(mpc status | awk 'NR==2 { gsub(/[(%)]/,""); print $4 }')"
	message="$(mpc status \
		| sed '2s/playing/  /;2s/paused/  /' \
		| sed '3s/ off */    /g;3s/ on */    /g;3s/ \{3\}/ \n/g')

	$(mpc stats)"

	appName="$(basename "$0")"
	msgTag='music'
	notify-send 'MPD' "$message" \
		--app-name="$appName" \
		--hint=int:value:"$progress" \
		--hint=string:x-dunst-stack-tag:"$msgTag" \
		--icon="$COVER_FILEPATH" \
		--urgency="$NOTIFICATION_URGENCY" \
		--replace-id=1061 # FIX: https://github.com/dunst-project/dunst/issues/1061
}

while true
do
	mpc current --wait
	ffmpeg \
		-loglevel quiet \
		-y \
		-i "$(xdg-user-dir MUSIC)/$(mpc --format %file% current)" \
		-an -vcodec copy "$COVER_FILEPATH"
	notify
done
