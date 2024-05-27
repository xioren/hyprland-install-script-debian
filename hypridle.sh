#!/bin/bash

# install deps
# hyprlang >= 0.4
sudo apt install -y \
libsdbus-c++-dev \
libwayland-dev \
wayland-protocols

git clone https://github.com/hyprwm/hypridle.git && cd hypridle

# build
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
cmake --build ./build --config Release --target hypridle -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

# make
sudo cmake --install build
