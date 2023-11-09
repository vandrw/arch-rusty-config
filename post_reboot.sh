# Update system
sudo pacman -Syu --noconfirm
sudo pacman -S --needed base-devel --noconfirm

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
makepkg -si --noconfirm

echo "Cleaning up paru build files.."
cd ..
rm -rf paru

echo "Installing additional AUR packages"
paru -S tlrc catppuccin-cursors-mocha rofi-lbonn-wayland sway-audio-idle-inhibit-git xwaylandvideobridge-git --noconfirm 

curl -sS https://github.com/elkowar.gpg | gpg --import -i -
curl -sS https://github.com/web-flow.gpg | gpg --import -i -
paru -S eww-wayland

# paru -S hyprland-nvidia --noconfirm # If you have an nvidia card and running into issues

# Initialize apps that need it
broot --install
tldr --update
bat cache --build

# Enable greetd after everything is installed. Otherwise, it will start right into hyprland.
systemctl enable wireplumber
systemctl enable pipewire
systemctl enable greetd