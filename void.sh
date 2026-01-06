#!/bin/bash

# Append configurations to .bash_profile

mkdir -p "$HOME/.config/sway"
cp "$HOME/.dotfiles/swayfx/.config/sway/kdb.example" "$HOME/.config/sway/keyboard"
