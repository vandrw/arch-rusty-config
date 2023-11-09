#!/bin/bash

# Find all users on the system
for user in $(ls /home); do
    if [ "$user" != "lost+found" ]; then
        users+=($user)
    fi
done

# If there is more than one user, ask which user to install for
if [ ${#users[@]} -gt 1 ]; then
    echo "Multiple users found on system. Please select a user to install for:"
    select user in "${users[@]}"; do
        if [[ " ${users[@]} " =~ " ${user} " ]]; then
            break
        else
            echo "Invalid selection"
        fi
    done
else
    user=${users[0]}
fi

echo "Installing for user $user"

# chroot as the user
arch-chroot /mnt -u $user
cd /home/$user

# Update system
sudo pacman -Syyu --noconfirm
sudo pacman -S --needed base-devel --noconfirm

echo "Installing Rustup"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Intialize rustc and cargo
echo "Initializing Rust"
rustup toolchain install stable
rustup default stable
rustup update

# Rust language server
echo "Installing Rust Language Server"
rustup component add clippy
rustup component add rust-analyzer

echo "Installing paru, a yay replacement written in Rust"
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

echo "Cleaning up paru build files"
cd ..
rm -rvf paru

# greetd is by default configured through /etc/greetd/config.toml
# make a link to the config file in the repo?
# greetd -c ~/.config/greetd/config.toml

echo "Installing additional AUR packages"
paru -S tlrc catppuccin-cursors-mocha rofi-lbonn-wayland eww-wayland sway-audio-idle-inhibit-git xwaylandvideobridge-git --noconfirm 
# hyprctl setcursor Catppuccin-Mocha-Dark 16 -- if the cursor doesn't work
# xwaylandvideobridge should autostart on login
# paru -S hyprland-nvidia --noconfirm # If you have an nvidia card and running into issues

# Initialize apps that need it
broot --install
tldr --update
bat cache --build

# Enable
systemctl enable wireplumber
systemctl enable pipewire
systemctl enable greetd
