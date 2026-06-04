#!/bin/bash

for pid in $(pgrep -x waybar 2>/dev/null); do
  kill "$pid"
done

for pid in $(pgrep -x swaync 2>/dev/null); do
  kill "$pid"
done

for pid in $(pgrep -x hyprpaper 2>/dev/null); do
  kill "$pid"
done

waybar &
swaync &
hyprpaper &
