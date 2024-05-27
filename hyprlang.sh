#!/bin/bash


# get
git clone https://github.com/hyprwm/hyprlang.git && cd hyprlang

# build
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprlang -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

# make
sudo cmake --install ./build
