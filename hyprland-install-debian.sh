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
build-essential \
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
polkit-kde-agent-1 \
seatd \
qtwayland5 \
qt6-wayland \
wget \
xdg-desktop-portal \
xdg-desktop-portal-gtk \
xcb-proto \
xutils-dev \
xwayland


# build and install libxcb-errors
git clone https://gitlab.freedesktop.org/xorg/lib/libxcb-errors && cd libxcb-errors
git submodule update --init
bash autogen.sh
make && sudo make install
sudo ldconfig
cd ..


# select xdg-desktop backend
echo "please select a xdg-desktop-portal backend"
echo "1: xdg-desktop-portal-wlr"
echo "2: xdg-desktop-portal-hyprland"
read -p "(1 or 2): " choice

if [ "$choice" == "1" ]; then
        sudo apt install -y xdg-desktop-portal-wlr
elif  [ "$choice" == "2" ]; then
        sudo apt install -y cmake ninja-build libsystemd-dev libgbm-dev libpipewire-0.3-dev libspa-0.2-dev
        git clone --recursive "https://github.com/hyprwm/xdg-desktop-portal-hyprland"
        cd xdg-desktop-portal-hyprland
        make all && sudo make install
        cd ..
else
        # IDEA: could default to 1 instead of exit
        echo "invalid choice"
        exit 1
fi


# install hyprland
wget https://github.com/hyprwm/Hyprland/releases/download/v$HYPRLAND_VERSION/v$HYPRLAND_VERSION.tar.gz
tar -xf v$HYPRLAND_VERSION.tar.gz && cd hyprland/
sudo mv hyprctl Hyprland /usr/bin/
sudo mv libwlroots.so.* /usr/lib/
sudo mkdir -p /usr/share/wayland-sessions/
sudo mv example/hyprland.desktop /usr/share/wayland-sessions/
mkdir -p $CONFIG_PATH
mv example/hyprland.conf $CONFIG_PATH


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
        libmagic1 \   
        libmagic-dev \
        mako-notifier \
        rofi \
        waybar
        git clone https://github.com/hyprwm/hyprpaper && cd hyprpaper
        make all && sudo make install
        cd ..
elif  [ "$choice" == "2" ]; then
        # choose

        # hyprpaper 
        echo "install hyprpaper wallpaper utility?"
        read -p "(y or n): " choice

        if [ "$choice" == "y" ]; then
                sudo apt install -y libmagic1 libmagic-dev
                git clone https://github.com/hyprwm/hyprpaper && cd hyprpaper
                make all && sudo make install
                cd ..
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
                sudo apt install -y rofi
        fi

        # waybar
        echo "install waybar status bar?"
        read -p "(y or n): " choice

        if [ "$choice" == "y" ]; then
                sudo apt install -y waybar
        fi
fi


# remove temp dir?
echo "installation complete"
