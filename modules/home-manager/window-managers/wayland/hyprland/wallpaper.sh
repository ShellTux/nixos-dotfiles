#!/bin/sh
set -e

WALL_HOME=~/Wallpapers/Imagens
INTERVAL_SECONDS=600

random_wallpaper() {
	find $WALL_HOME -type f | shuf --head-count=1
}

update_wallpaper() {
	swww img --transition-type=random "$(random_wallpaper)"
}

daemon_wallpaper() {
	while true
	do
		update_wallpaper "$img"
		sleep "$INTERVAL_SECONDS"
	done
}

case "$1" in
	daemon) daemon_wallpaper ;;
esac
