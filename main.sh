#!/bin/bash

set -e

# initial setup
mkdir hyprland-tmp && cd hyprland-tmp

# install dependenciesn
echo "installing deps"
../deps.sh

# install fonts
echo "installing fonts"
../fonts.sh

# build and install libxcb-errors
echo "installing libxcb-errors"
../libxcb-errors.sh
# install hyprland
echo "installing hyprland"
../hyprland.sh
echo "installing hyprlang"
../hyprlang.sh
echo "installing hyprcursor"
../hyprcursor.sh


# select xdg-desktop backend
echo "please select a xdg-desktop-portal backend"
echo "1: xdg-desktop-portal-wlr"
echo "2: xdg-desktop-portal-hyprland"
read -p "(1 or 2): " choice

if [ "$choice" == "1" ]; then
        sudo apt install -y xdg-desktop-portal-wlr
elif  [ "$choice" == "2" ]; then
        ./xdg-desktop-portal-hyprland.sh
else
        # IDEA: could default to 1 instead of exit
        echo "invalid choice"
        exit 1
fi

# install polkit agent
echo "install polkit agent?"
echo "1: policykit-1-gnome"
echo "2: polkit-kde-agent-1"
read -p "(1 or 2): " choice
if [ "$choice" == "1" ]; then
        sudo apt install -y policykit-1-gnome
elif [ "$choice" == "2" ]; then
        sudo apt install -y polkit-kde-agent-1
fi


# install extras
# TODO: add more options
echo "install utilities?"
echo "1: all"
echo "2: choose"
echo "3: none"
read -p "(1, 2, or 3): " choice

if [ "$choice" == "1" ]; then
        # all
        sudo apt install -y \
        mako-notifier \
        waybar
        echo "installing hypridle"
        ../hypridle.sh
        echo "installing hyprlock"
        ../hyprlock.sh
        echo "installing hyprpaper"
        ../hyprpaper.sh
        echo "installing rofi"
        ../rofi-wayland.sh
elif  [ "$choice" == "2" ]; then
        # choose

        # hypridle
        echo "install hypridle screen idle utility?"
        read -p "(y or n): " choice

        if [ "$choice" == "y" ]; then
                ../hypridle.sh
        fi

        # hyprlock
        echo "install hyprlock screen lock utility?"
        read -p "(y or n): " choice

        if [ "$choice" == "y" ]; then
                ../hyprlock.sh
        fi

        # hyprpaper 
        echo "install hyprpaper wallpaper utility?"
        read -p "(y or n): " choice

        if [ "$choice" == "y" ]; then
                ../hyprpaper.sh
        fi

        # mako
        echo "install mako notifier?"
        read -p "(y or n): " choice

        if [ "$choice" == "y" ]; then
                sudo apt install -y mako-notifier
        fi

        # rofi
        echo "install rofi app launcher?"
        read -p "(y or n): " choice

        if [ "$choice" == "y" ]; then
                ../rofi-wayland.sh
        fi

        # waybar
        echo "install waybar status bar?"
        read -p "(y or n): " choice

        if [ "$choice" == "y" ]; then
                sudo apt install -y waybar
        fi
fi


cd .. && sudo rm -r hyprland-tmp
echo "installation complete"
