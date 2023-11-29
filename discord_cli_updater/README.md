# Discord CLI updater

This is a tool to update Discord on Ubuntu. It's kinda cursed but it works, for now. 

It searches for the last valid download URL for the `.deb` package on Discord's site using `curl`. The package is then downloaded with `wget` and installed with `dpkg`. Finally the  `.deb` package is deleted. 

The script stores the last version number on a `.txt` file. If it doesn't find one it creates one. 


## To-do

[  ] Make it so that the script searches for version numbers above 0.0.xx (e.g. 0.1.0). This will not be useful for a long time, but might as well put it when i have the time

