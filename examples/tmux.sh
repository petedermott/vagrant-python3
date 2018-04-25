#!/bin/sh
tmux start-server
tmux new-session -d -s selenium
tmux send-keys -t selenium:0 './chromedriver' C-m
tmux new-session -d -s chrome-driver
tmux send-keys -t chrome-driver:0 'java -jar selenium-server-standalone.jar' C-m
