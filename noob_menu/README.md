# Noob menu

## Required packages

1. [xdotool](https://github.com/jordansissel/xdotool), a utility for fake keyboard/mouse input, window management, and more 
2. [YAD (Yet Another Dialog)](https://github.com/v1cont/yad) a utility for dialog boxes
3. [Rofi](https://github.com/davatorium/rofi), [dmenu](https://tools.suckless.org/dmenu/) or whatever you prefer! Just make sure to edit the script accordingly.

## Introduction

A simple menu written in bash and using YAD for graphical interface. It was made for two reasons:

1. Not everyone knows how to use a tiling window manager, and consequently not everyone knows how to open software, turn off the machine or do other tasks. Adding an icon to the taskbar/panel of choice (i use `xfce4-panel` on my Arch setup with i3wm) where one would usually find the menu button helps eventual friends/colleagues use the machine with more ease, while at the same time giving them clues about keybindings.
2. I wanted to experiment with bash and found out about Zenity and YAD, in the end settling on the latter.

Yeah, i know it's not high-brow humour, but what can you do, i like to heckle my friends.

## How to use it

First create the launcher needed for your bar/panel. Since i use `xfce4-panel` i just added an application launcher at the utter left.

Then play around with the `--geometry=WidthxHeight+Xpos+Ypos` parameter to make it appear near your launcher and with the desired size.  
Right now it's set as `--geometry=220x300+0+20` which is the minimum needed size to display correctly and the coordinates make it appear on screen just below the icon in my panel, which in my case has a 19 pixels row size. 

Should you not be using a distro relying on [Systemd](https://systemd.io/) like [Artix](https://artixlinux.org/) or [Void Linux](https://voidlinux.org/), make sure to edit the poweroff and reboot options accordingly.

## Why YAD and not Zenity?

Why use YAD and not the usually already present on system Zenity? The answer is simple: the `--geometry` option, only present in YAD, which allowed me to make the dialog box spawn where i want it to simulate a dropdown menu.

## Known issues

1. When used on a dual monitor setup with different max resolutions, it usually does not spawn on the right (x,y) coordinates on the higher res one.  

2. On my Arch i3wm setup YAD is not set by default as floating (unlike Zenity). The easiest workaround i found was adding to my i3wm config file the line  
`for_window [title="YAD"] floating enable `  
and naming every YAD instance with "YAD" in the name. I'm sure there are more elegant ways but I'll investigate them in the future. If you know any please let me know!  

3. For some reason rofi refused to launch from the script, so i used the quick and dirty workaround of using `xdotool` to simulate the keybind press. Again, if you know why that's happening, please let me know!