#!/bin/bash

# Append configurations to .bash_profile

cat <<EOL >> "$HOME/.bash_profile"

# Load eww_scale
[ -f "\$HOME/.eww_scale" ] && source "\$HOME/.eww_scale"

# Ruby Path
export GEM_HOME="\$(gem env user_gemhome)"
export PATH="\$PATH:\$GEM_HOME/bin"

# Mpd music dir, you also have to configure mpd...
export MPD_MUSIC_DIR="\$HOME/where-musics-are"

# Where Dotfiles are, if not ~/.dotfiles
export DOTFILES_DIR="\$HOME/.dotfiles"

EOL

echo "Configurations added to .bash_profile. Please restart your terminal or run 'source ~/.bash_profile' to apply the changes."
