#!/bin/sh
set -e

# shellcheck disable=SC2068
MANPAGER='nvim +Man!' man $@
