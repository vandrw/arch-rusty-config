# Check if internet is working
if ! ping -c 1 archlinux.org; then
    echo "Error: No internet connection"
    exit 1
fi

# Change ownership of files to user
user=$(whoami)
sudo chown -R $user:$user $mnt_folder/home/$user/.config
sudo chown -R $user:$user $mnt_folder/home/$user/.local

# Update system
sudo pacman -Syu --noconfirm
sudo pacman -S --needed base-devel --noconfirm

# Install nvidia drivers if nvidia card is detected
if [ `lspci -k | grep -A 2 -E "(VGA|3D)" | grep -i nvidia | wc -l` -gt 0 ]; then
        echo "Nvidia card detected..."
        sudo pacman -S --needed nvidia-utils --noconfirm
        paru -S hyprland-nvidia-git --noconfirm
fi

# Intialize rustc and cargo
echo "Initializing Rust"
rustup toolchain install stable
rustup default stable
rustup update

# Rust language server
echo "Installing Rust Language Server"
rustup component add clippy rust-analyzer

echo "Installing paru, a yay replacement written in Rust"
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm

echo "Cleaning up paru build files.."
cd ..
rm -rf paru

echo "Installing additional AUR packages"
paru -S \
    catppuccin-gtk-theme-mocha \
    catppuccin-cursors-mocha \
    sway-audio-idle-inhibit-git \
    xdg-desktop-portal-hyprland-git \
    swww \
    wleave-git \
    waybar-hyprland-git \
    rofi-lbonn-wayland \
    tlrc \
    numbat \
    librewolf-bin \
    logseq-desktop-wayland-bin \
    grimblast-git \
    yt-dlp \
    --noconfirm
# xwaylandvideobridge-git disabled for now

curl -sS https://github.com/elkowar.gpg | gpg --import -i -
curl -sS https://github.com/web-flow.gpg | gpg --import -i -
paru -S eww-wayland --noconfirm

# paru -S hyprland-nvidia --noconfirm # If you have an nvidia card and running into issues

# Initialize apps that need it
curl "https://github.com/Canop/broot/blob/main/resources/icons/vscode/vscode.ttf" -o ~/.local/share/fonts/vscode.ttf
broot --install
tldr --update
bat cache --build
ufw enable
starship init nu > ~/.local/share/starship.nu
zoxide init nushell > ~/.local/share/zoxide.nu
atuin init nu > ~/.local/share/atuin.nu

# Make tty have Catppuccin Mocha theme
bootloader_entry=$(ls /boot/loader/entries/ | grep -v "fallback")
tty_theme=" vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166 vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173 vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"

if [[ $(tail -n 1 /boot/loader/entries/$bootloader_entry) == "options"* ]]; then
    if [[ $(tail -n 1 /boot/loader/entries/$bootloader_entry) == *"vt.default_red"* ]]; then
        echo "Catppuccin Mocha theme already set. Skipping..."
    else
        echo "Setting Catppuccin Mocha theme to tty..."
        printf "$tty_theme" | sudo tee -a /boot/loader/entries/$bootloader_entry
    fi
else
    echo "Error: Last line of /boot/loader/entries/$bootloader_entry does not start with \"options\""
    echo "Please manually add the following to the \"options\" line:"
    echo $tty_theme
fi

echo "HandlePowerKey=suspend" | sudo tee -a /etc/systemd/logind.conf

# Set default shell to nushell
chsh -s /bin/nu

# Enable greetd after everything is installed. Otherwise, it will start right into hyprland.
sudo systemctl enable greetd ufw NetworkManager