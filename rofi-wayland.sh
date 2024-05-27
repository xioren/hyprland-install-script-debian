#!/bin/bash


# install deps
sudo apt install -y \
bison \
check \
flex \
libcairo2-dev \
libglib2.0-dev \
libpango1.0-dev \
libstartup-notification0-dev \
libwayland-dev \
libxcb-util-dev \
libxkbcommon-dev \
libxcb-cursor-dev \
libxcb-xinerama0-dev \
meson \
ninja-build \
pkg-config \
wayland-protocols

# clone
git clone https://github.com/lbonn/rofi.git && cd rofi

# build
meson setup build && ninja -C build
sudo ninja -C build install
