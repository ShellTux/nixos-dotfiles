#!/bin/sh
set -e

printf "IPv4:\n-----------------\n"
ip -oneline address show | cut --delimiter=' ' --fields=2,7 | grep --invert-match : | column --table
printf "\nIPv6:\n-----------------\n"
ip -oneline address show | cut --delimiter=' ' --fields=2,7 | grep : | column --table
