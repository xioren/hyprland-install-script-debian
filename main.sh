#!/bin/bash

set -e

# highest version compatible with Debian 12/testing
HYPRLAND_VERSION="0.27.0"
CONFIG_PATH=~/.config/hypr/


# initial setup
mkdir hyprland-tmp && cd hyprland-tmp


# install dependencies
sudo apt update && sudo apt install -y \
autoconf \
automake \
build-essential \
cmake \
fontconfig \
gettext \
gettext-base \
git \
glslang-tools \
kitty \
libavcodec-dev \
libavformat-dev \
libavutil-dev \
libdisplay-info-dev \
libdrm-dev \
libegl-dev \
libegl1-mesa-dev \
libffi-dev \
libfontconfig-dev \
libgles2 \
libinput-bin \
libinput-dev \
libliftoff-dev \
libpixman-1-dev \
libseat-dev \
libtool \
libudev-dev \
libvulkan-dev \
libwayland-dev \
libxcb-composite0-dev \
libxcb-dri3-dev \
libxcb-ewmh2 \
libxcb-ewmh-dev \
libxcb-present-dev \
libxcb-icccm4-dev \
libxcb-render-util0-dev \
libxcb-res0-dev \
libxcb-xinput-dev \
libxkbcommon-x11-dev \
libxkbregistry-dev \
libxkbcommon-dev \
libxml2-dev \
make \
seatd \
qtwayland5 \
qt6-wayland \
wayland-protocols \
wget \
xdg-desktop-portal \
xdg-desktop-portal-gtk \
xcb-proto \
xutils-dev \
xwayland


# build and install libxcb-errors
./libxcb-errors.sh


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


# install hyprland
./hyprland.sh
./hyprlang.sh
./hyprcursor.sh


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
        ./hypridle.sh
        ./hyprlock.sh
        ./hyprpaper.sh
        ./rofi-wayland.sh
elif  [ "$choice" == "2" ]; then
        # choose
        
        # hypridle
        echo "install hypridle screen idle utility?"
        read -p "(y or n): " choice

        if [ "$choice" == "y" ]; then
                ./hypridle.sh
        fi

        # hyprlock
        echo "install hyprlock screen lock utility?"
        read -p "(y or n): " choice

        if [ "$choice" == "y" ]; then
                ./hyprlock.sh
        fi

        # hyprpaper 
        echo "install hyprpaper wallpaper utility?"
        read -p "(y or n): " choice

        if [ "$choice" == "y" ]; then
                ./hyprpaper.sh
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
                ./rofi-wayland.sh
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