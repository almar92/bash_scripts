#!/bin/bash

menu=("Programs" \
      "File search"\
      "Poweroff" \
      "Reboot" \
      "Lock")
keyb=("Ctrl+k" \
      "Ctrl+Alt+k"\
      "Ctrl+Alt+p"\
      "Ctrl+Alt+r"\
      "Ctrl+Alt+l")
ans=$(yad  --image=archlinux-logo \
	   --text="> Current year \n> Not using keybindings"  \
	   --geometry=220x300+0+20 \
	   --close-on-unfocus  \
	   --borders=2  \
	   --title="YAD Noob Menu" \
	   --separator="" \
	   --list \
	   --column=Item --column=Keybind \
	   "${menu[0]}" "${keyb[0]}" \
	   "${menu[1]}" "${keyb[1]}" \
	   "${menu[2]}" "${keyb[2]}" \
	   "${menu[3]}" "${keyb[3]}" \
	   "${menu[4]}" "${keyb[4]}" )

case "$ans" in

  "${menu[0]}${keyb[0]}" )
  
  xdotool key ctrl+k #God knows why rofi does not wanna start if i call it directly, so xdotool to the rescue 
  ;;

  "${menu[1]}${keyb[1]}")

  xdotool key ctrl+alt+k
  ;;

  "${menu[2]}${keyb[2]}")

    yad --image=xfsm-shutdown \
	--title="YAD Shutdown" \
	--text="Do you want to shut down the system?" \
	--question
    ans_p=$?

    if [ $ans_p -eq 0 ]; 
    then
	systemctl poweroff
    fi
    
    ;;
  "${menu[3]}${keyb[3]}")

    yad --image=xfsm-reboot \
	--title="YAD Reboot" \
	--text="Do you want to reboot the system?" \
	--question
    ans_r=$?

    if [ $ans_r -eq 0 ]; 
    then
	systemctl reboot
    fi

  ;;
  "${menu[4]}${keyb[4]}")

    xdotool key Ctrl+Alt+l #Replace with preferred method of locking screen, i used xdotool in order to only edit i3lock in the i3 config file
    ;;
esac
