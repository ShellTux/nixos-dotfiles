#!/bin/sh
set -e

usage() {
	echo "Usage: $(basename "$0") [amount] [+/-]"
	echo "The amount is in percentage (do not include %)"
	echo "amount   the amount to increase or decrease volume" \
		"(integer between 0 and 100)"
	echo "Example: $(basename "$0") 5 +"
	echo "Example: $(basename "$0") 5 -"
	exit 1
}

get_volume () {
      [ "$(command -v wpctl)" ] \
	      && wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}' \
	      && return
      [ "$(command -v pulsemixer)" ] \
	      && pulsemixer --get-volume | awk '{print $1}' \
	      && return
}

is_muted () {
      [ "$(command -v wpctl)" ] \
	      && [ ! "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep MUTED)" = "" ] \
	      && echo 1 || echo 0 && return
      [ "$(command -v pulsemixer)" ] \
	      && pulsemixer --get-mute \
	      && return
}

toggle_mute() {
	[ "$(command -v wpctl)" ] && wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && return
	[ "$(command -v pulsemixer)" ] && pulsemixer --toggle-mute && return
}

set_volume() {
	[ "$(command -v wpctl)" ] \
		&& wpctl set-volume @DEFAULT_AUDIO_SINK@ "$1%$2" \
		&& return
	[ "$(command -v pulsemixer)" ] \
		&& pulsemixer --change-volume "$2$1" \
		&& return
}

if [ $# -eq 0 ]
then
	printf 'Volume: %d%%\n' "$(get_volume)"
elif [ $# -eq 1 ]
then
	case "$1" in
		notify) ;;
		toggle | toggle-mute) toggle_mute ;;
		*) usage ;;
	esac
else
	case "$1 $2" in
		[0-9]\ [+-]) set_volume "$1" "$2" ;;
		*) usage ;;
	esac
fi

appName="$(basename "$0")"
msgTag='volume'
volume="$(get_volume)"
muted="$(is_muted)"
if [ "$muted" = 1 ]
then
	icon='audio-volume-muted'
else
	volume_level="$(echo "$volume" | awk '{ print sprintf("%.0f", $1/100*4) }')"
	case "$volume_level" in
		0) icon="audio-volume-low" ;;
		1) icon="audio-volume-medium" ;;
		2) icon="audio-volume-medium" ;;
		3) icon="audio-volume-high" ;;
		4) icon="audio-volume-high" ;;
	esac
fi
notify-send --app-name="$appName" \
	--urgency=low \
	--icon="$icon" \
	--hint=string:x-dunst-stack-tag:"$msgTag" \
	--hint=int:value:"$volume" "Volume: ${volume}%"
