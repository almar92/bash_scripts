#!/bin/bash

# simple script for tablet usage as second monitor
# at the moment using a HDMI to VGA adapter to simulate second monitor
# since NVIDIA card glitches when creating virtual outputs with intel card
# not optimal but oh well
# usage: in terminal type "./vnclol.sh []"

x_base=1280
y_base=800


if [ "$1" == "vertical" ]
then
  # max 10:16 aspect ratio obtainable on my machine
  xrandr --output HDMI-1-1 --mode "${x_base}x${y_base}" --rotate right
  y_base=1280
  x_base=800
elif [ "$1" == "horizontal" ]
then
  # max 16:10 aspect ratio obtainable on my machine
  xrandr --output HDMI-1-1 --mode "${x_base}x${y_base}" --rotate normal
elif [ -z "$1" ]
then
  echo "ERROR! Missing input"
  echo "usage: ./vnc_double_screen.sh [vertical/horizontal] [below/right] [x_scale y_scale](optional)"
  echo "If no scaling selected the option 1.5x1.5 will be set, resulting in 1920x1200 resolution"
  exit
elif [ -z "$2" ]
then
  echo "ERROR! Missing screen position, choose between [below/right]"
  exit
fi

# scaling to up the resolution
# 1.25x1.25 gives 1000x1600
# 1.50x1.50 gives 1200x1920

if [ -z "$3" ]
then
  echo "at least one scaling parameter not specified: setting to 1.5x1.5"
  x_scale=1.50
  y_scale=1.50
else
  x_scale=$3
  y_scale=$4
    if [ -z "$4" ]
    then
      echo "at least one scaling parameter not specified: setting to 1.5x1.5"
      x_scale=1.50
      y_scale=1.50
    fi
fi

# vnc via usb port
adb reverse tcp:5900 tcp:5900

# calculates the actual resolution with bc
x_bc=$(echo "$x_base * $x_scale" | bc)
y_bc=$(echo "$y_base * $y_scale" | bc)

# rough hack to convert bc's float output to int
x=${x_bc%.*}
y=${y_bc%.*}

# xrandr applies scaling
xrandr --output HDMI-1-1 --scale ${x_scale}x${y_scale}

if [ "$2" == "below" ]
then
  xrandr --output HDMI-1-1 --below eDP-1-1
  nitrogen --restore
  x11vnc -clip "${x}x${y}"+0+1080 -localhost -multiptr -ncache 10
  elif [ "$2" == "right" ]
then
  xrandr --output HDMI-1-1 --right-of eDP-1-1
  nitrogen --restore
  x11vnc -clip "${x}x${y}"+1920+0 -localhost -multiptr -ncache 10
fi


