#!/bin/sh
set -e

if [ $# -le 0 ]
then
	exit 1
fi

TIME_SECONDS="$1"

sleep "$TIME_SECONDS"
