# Using VNC to transform a tablet into a second monitor

This is a jankier rielaboration of [This project](https://github.com/dianariyanto/virtual-display-linux) by [Dian Ariyanto](https://github.com/dianariyanto). 
Since my machine has a NVIDIA card that REALLY dislikes intel generated virtual outputs (graphical glithces and flashing on the screen), i use a HDMI to VGA adapter for the second monitor and then cast it via `x11vnc`.

## Usage

Runninn the script without arguments returns the manual:
`` 
ERROR! Missing input
usage: ./vnclol.sh [vertical/horizontal] [below/right] [x_scale y_scale](optional)
If no scaling selected the option 1.5x1.5 will be set, resulting in 1920x1200 resolution
``
