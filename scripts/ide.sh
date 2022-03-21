#!/bin/bash

tmux new-window
tmux select-window -t 0
tmux split-window -h -p 30
tmux send-keys -t 0 C-z 'lvim' Enter &
tmux send-keys -t 1 C-z 'npm run dev' Enter &
tmux select-pane -t 0
