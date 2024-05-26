#!/bin/bash


# install deps
sudo apt install -y \
# hyprlang >= 0.4
libcairo2-dev \
libdrm-dev \
libegl1-mesa-dev \
libgl1-mesa-dev \
libmagic-dev \
libpam0g-dev \
libpango1.0-dev \
libwayland-dev \
libxkbcommon-dev \
# libxkbcommon-x11-dev \
wayland-protocols

# get
git clone https://github.com/hyprwm/hyprlock.git && cd hyprlock

# build
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
cmake --build ./build --config Release --target hyprlock -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
# make
sudo cmake --install build