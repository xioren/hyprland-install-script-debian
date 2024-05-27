#!/bin/bash


# install deps
# hyprlang
sudo apt install -y \
libdrm-dev \
libgbm-dev \
libpipewire-0.3-dev \
libsdbus-c++-dev \
libspa-0.2-dev \
libwayland-client0 \
qt6-base-dev \
wayland-protocols


# hyprland-protocols
./hyprland-protocols.sh

# get
git clone --recursive https://github.com/hyprwm/xdg-desktop-portal-hyprland.git && cd xdg-desktop-portal-hyprland

# make and install
cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build
sudo cmake --install build
