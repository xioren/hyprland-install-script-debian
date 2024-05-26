#!/bin/bash

# clone
git clone https://gitlab.freedesktop.org/xorg/lib/libxcb-errors && cd libxcb-errors

# make, install
git submodule update --init
bash autogen.sh
make && sudo make install
sudo ldconfig