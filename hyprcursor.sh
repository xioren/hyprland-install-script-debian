#!/bin/bash

# install deps
# hyprlang >= 0.4.2
sudo apt install -y \
libcairo2-dev \
librsvg2-dev \
libtomlplusplus-dev \
libzip-dev

git clone https://github.com/hyprwm/hyprcursor.git && cd hyprcursor

# build
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

# make
sudo cmake --install build
