#!/bin/bash


# install deps
sudo apt install -y \
bison \
check \
flex \
libcairo2-dev \
libglib2.0 \
libpango1.0-dev \
libwayland-dev \
libxkbcommon-dev \
pkg-config \
wayland-protocols

# clone
git clone https://github.com/lbonn/rofi.git && cd rofi

# build
mkdir build && cd build
../configure
make && make install