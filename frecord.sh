#!/bin/bash

CURRENT_DATE=$(date +"%b%d%Y")
FILENAME="${CURRENT_DATE}-record.mp4"

# Set desired frame rate
FRAMERATE=60

# Start ffmpeg with both screen and webcam input
sleep 3 && ffmpeg \
  -video_size 1920x1080 -framerate $FRAMERATE -f x11grab -i :0.0 \
  -f pulse -i default \
  -f v4l2 -framerate $FRAMERATE -i /dev/video0 \
  -filter_complex "[2:v]scale=320:240[cam];[0:v][cam]overlay=W-w:H-h[v]" \
  -map "[v]" -map "1:a" \
  $FILENAME \
  > out.txt 2> err.txt

