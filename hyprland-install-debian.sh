#!/bin/bash

set -e

HYPRLAND_VERSION="0.27.0"
CONFIG_PATH=~/.config/hypr/


# initial setup
mkdir hyprland-tmp && cd hyprland-tmp


# install dependencies
sudo apt install -y \
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
seatd \
wget \
xcb-proto \
xdg-desktop-portal-wlr \
xutils-dev \
xwayland


# build and install libxcb-errors
git clone https://gitlab.freedesktop.org/xorg/lib/libxcb-errors && cd libxcb-errors
git submodule update --init
bash autogen.sh
make && sudo make install
sudo ldconfig
cd ..

# install hyprland
wget https://github.com/hyprwm/Hyprland/releases/download/v$HYPRLAND_VERSION/v$HYPRLAND_VERSION.tar.gz
tar -xf v$HYPRLAND_VERSION.tar.gz && cd hyprland/
sudo mv hyprctl Hyprland /usr/bin/
sudo mv libwlroots.so.* /usr/lib/
sudo mkdir -p /usr/share/wayland-sessions/
sudo mv example/hyprland.desktop /usr/share/wayland-sessions/
mkdir -p $CONFIG_PATH
mv example/hyprland.conf $CONFIG_PATH

# remove temp dir?
echo "hyprland installed"
