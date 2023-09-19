#!/bin/sh

# needs at least one arg
if [ $# -eq 0 ]; then
    echo "Usage: tmux_start.sh <directories>"
    exit 1
fi


tmux new-session -d '$SHELL' -s 'main'
tmux send-keys "cd $1" Enter
tmux send-keys "$EDITOR ." Enter
tmux split-window -h '$SHELL'

# loop over all but first argument
for i in "${@:2}"; do
    if [ ! -d "$i" ]; then
        echo "Error: $i is not a directory"
        exit 1
    fi
    tmux new-window '$SHELL'
    tmux send-keys "cd $i" Enter
    tmux send-keys "$EDITOR ." Enter
    tmux split-window -h '$SHELL'
done

tmux -2 attach-session -d -t "main"
