#!/bin/bash

HYPRLAND_VERSION="v0.40.0"

# get hyprland
wget https://github.com/hyprwm/Hyprland/releases/download/v$HYPRLAND_VERSION/v$HYPRLAND_VERSION.tar.gz
tar -xf v$HYPRLAND_VERSION.tar.gz && cd hyprland

# install
sudo mv hyprctl Hyprland hyprpm /usr/bin/
sudo mv libwlroots.so.* /usr/lib/
sudo mkdir -p /usr/share/wayland-sessions/
sudo mv example/hyprland.desktop /usr/share/wayland-sessions/
mkdir -p $CONFIG_PATH
mv example/hyprland.conf $CONFIG_PATH