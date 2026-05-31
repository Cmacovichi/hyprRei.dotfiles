#!/bin/bash
if pgrep wf-recorder > /dev/null; then
    pkill wf-recorder
    pactl unload-module module-loopback
    pactl unload-module module-null-sink
    notify-send "Recording stopped"
else
    pactl load-module module-null-sink sink_name=combined sink_properties=device.description=combined
    pactl load-module module-loopback source=alsa_input.pci-0000_00_1f.3.analog-stereo sink=combined latency_msec=50 source_dont_move=true sink_dont_move=true
    pactl load-module module-loopback source=alsa_output.pci-0000_00_1f.3.analog-stereo.monitor sink=combined latency_msec=50
    sleep 0.5
    wf-recorder -f "$HOME/Screen Recording/$(date +%Y-%m-%d_%H-%M-%S).mp4" --audio=combined.monitor &
    pactl set-source-volume alsa_input.pci-0000_00_1f.3.analog-stereo 50%
    notify-send "Recording started"
fi
