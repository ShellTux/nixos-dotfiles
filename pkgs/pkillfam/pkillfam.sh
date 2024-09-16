#!/bin/sh
set -e

FORCE_KILL=0
DRY_RUN=0
VERBOSE=0

usage() {
	echo "Usage: $(basename "$0") [options] <process_name>"
	echo "Options:"
	echo "  -9, --force        Force kill processes"
	echo "  -n, --dry-run          Display commands without executing them"
	echo "  -v, --verbose          Print detailed output"
	echo "  -h, --help         Display this help message"
}

while [ $# -gt 0 ]
do
	case "$1" in
		-9|--force)
			FORCE_KILL=1
			;;
		-n|--dry-run)
			DRY_RUN=1
			;;
		-v|--verbose)
			VERBOSE=1
			;;
		-h|--help)
			usage
			exit 0
			;;
		*)
			PROCESS_NAME="$1"
			;;
	esac
	shift
done

if [ -z "$PROCESS_NAME" ]
then
	usage
	exit 1
fi

PARENT_PID=$(pgrep --oldest "$PROCESS_NAME")

if [ -z "$PARENT_PID" ]
then
	echo "Error: No such process with name '$PROCESS_NAME'."
	exit 1
fi

CHILD_PIDS=$(pgrep --parent "$PARENT_PID")

if [ -n "$CHILD_PIDS" ]
then
	MESSAGE="Killing child processes: $CHILD_PIDS"

	if [ $VERBOSE -eq 1 ]
	then
		echo "$MESSAGE"
	fi

	if [ $DRY_RUN -eq 0 ]
	then
		# shellcheck disable=SC2086
		kill $CHILD_PIDS
	else
		echo "Dry-run: $MESSAGE"
		echo "Command: kill $CHILD_PIDS"
	fi
fi

MESSAGE="Killing parent process: $PARENT_PID"
if [ $VERBOSE -eq 1 ]
then
	echo "$MESSAGE"
fi

if [ $DRY_RUN -eq 0 ]
then
	if [ $FORCE_KILL -eq 1 ]
	then
		# shellcheck disable=SC2086
		kill -9 $PARENT_PID
	else
		# shellcheck disable=SC2086
		kill $PARENT_PID
	fi
else
	echo "Dry-run: $MESSAGE"
	if [ $FORCE_KILL -eq 1 ]
	then
		echo "Command: kill -9 $PARENT_PID"
	else
		echo "Command: kill $PARENT_PID"
	fi
fi

echo "Done."
