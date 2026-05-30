#!/bin/bash
if pgrep wf-recorder > /dev/null; then
    pkill wf-recorder
    notify-send "Recording stopped"
else
    mkdir -p ~/Videos
    wf-recorder -f "$HOME/Screen Recording/$(date +%Y-%m-%d_%H-%M-%S).mp4" &
    notify-send "Recording started"
fi
