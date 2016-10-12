#!/bin/bash

# This script shortcuts the creation of a Desktop shortcut for Applications on a Linux desktop environment
# Note: This is not for use with terminal-centric scripts or apps, just GUI apps
# You may also rename the shortcut after it is created to fit your liking.

# This part of the script will search for the PNG associated with the first argument, which is the program you want to create a shortcut for
# If this isn't available somewhere already, it will prompt the user for the directory

icon="$(find /usr -iname "*$1*.png" 2>/dev/null | grep 256 | grep hicolor)"
if [[ $? != 0 ]]; then
        icon="$(find /opt -iname "*$1*.png" 2>/dev/null | grep 256 | grep hicolor)"
        if [[ $? != 0 ]]; then
                icon="$(find ~ -iname "*$2*.png" 2>/dev/null)"
                if [[ $? != 0 ]]; then
                        echo "No icon pictures found with name $1."
                        echo -n "Please enter the directory of the picture you wish to use for icon: "
                        read -e icon
                else
                        echo "Icon found.  Using $icon."
                fi
        else
                echo "Icon found.  Using $icon."
        fi
else
        echo "Icon found.  Using $icon."
fi

exe="$(find /usr/bin -iname "**$1" 2>/dev/null)"
echo -n "Please enter the name of the shortcut: "
read shortcut
short=/home/assessor/Desktop/"$shortcut".desktop

echo "[Desktop Entry]
Encoding=UTF-8
Name=$shortcut
Exec=$exe
Terminal=false
Type=Application
Icon=$icon
Categories=Apps;
Name[en-US]=$shortcut" > $short
chown assessor:assessor $short
chmod 755 $short
