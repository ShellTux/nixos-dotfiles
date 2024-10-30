#!/bin/sh
set -e

for arg
do
	file="$arg"
	mkdir --parents "$(dirname "$file")"
	touch "$file"
done
