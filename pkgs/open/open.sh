#!/bin/sh
set -e

for arg
do
	xdg-open "$arg" &
done
