#!/bin/sh

kill_waybar() {
	pkill waybar || true
}

cleanup() {
	kill_waybar
	exit
}

kill_waybar

trap 'cleanup' EXIT

while true
do
	waybar || true
	sleep 1
done
