#!/bin/sh
set -e

mkdir --parents "$@"
cd "$1" || exit
