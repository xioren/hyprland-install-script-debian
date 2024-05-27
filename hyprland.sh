#!/bin/bash

HYPRLAND_VERSION="v0.40.0"
CONFIG_PATH=~/.config/hypr/


# get hyprland
wget https://github.com/hyprwm/Hyprland/releases/download/$HYPRLAND_VERSION/$HYPRLAND_VERSION.tar.gz
tar -xf $HYPRLAND_VERSION.tar.gz && cd hyprland

# install
sudo mv hyprctl Hyprland hyprpm /usr/bin/
#sudo mv libwlroots.so.* /usr/lib/
sudo mkdir -p /usr/share/wayland-sessions/
sudo mv example/hyprland.desktop /usr/share/wayland-sessions/
mkdir -p $CONFIG_PATH
mv example/hyprland.conf $CONFIG_PATH
