#!/bin/bash

# install deps
sudo apt install -y \
file \
# hyprlang \
libcairo2-dev \
libglvnd-dev \
libglvnd-core-dev \
libjpeg-dev \
libjpeg62-turbo-dev \
libpam0g-dev \
libpango1.0-dev \
libwayland-dev \
libwebp-dev \
libxkbcommon-dev \
# libxkbcommon-x11-dev \
wayland-protocols \
xwayland

git clone https://github.com/hyprwm/hyprpaper.git && cd hyprpaper

# build
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprpaper -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

# make
cmake --install ./build