#!/bin/bash

echo -e "[!] setting workspace shortcuts"
# Set workspace number to static 10
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10

# Open terminal with <Super> + <Return>
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super><Return>'

# Close windos with <Super> + <Shift> + q
gsettings set org.gnome.desktop.wm.keybindings close "['<Super><Shift>q']"

for i in {1..9}; do
    # Unset keybindings for launching applications with <Super> + <number>
    gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
    # Set keybindings for switching to workspace with <Super> + <number>
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i']"
    # Set keybindings for moving to workspace with <Super> + <Shift> + <number>
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Super><Shift>$i']"
done

# 10th workspace is a bit different
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Super>0']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 "['<Super><Shift>0']"

echo -e "\n[!] installing extensions"

# install GNOME shell extensions
INSTALLER="$(dirname $0)/extension-installer.sh"
EXTENSIONS="$(dirname $0)/extensions.txt"

# Read each line of extensions.txt
while IFS= read -r line; do
    # Extract the number before the first /
    extension_number=$(echo "$line" | cut -d'/' -f1)
    
    # Call install-extensions with the extracted number
    bash $INSTALLER "$extension_number"
done < $EXTENSIONS

# this is not available on wayland
# bash $INSTALLER --restart-shell
