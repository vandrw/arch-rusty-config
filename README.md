# dotfiles

My Arch Linux configuration files.

__Window manager:__ hyprland<br>
__Bar:__ eww<br>
__Programming:__ python (w/ ruff-lsp), rust (w/ rust-analyzer and taplo-cli for TOML)<br>
__Terminal:__ wezterm<br>

| __Wayland app__                                         | __Description__                                               | Language |
|---------------------------------------------------------|---------------------------------------------------------------|----------|
| [greetd](https://git.sr.ht/~kennylevinsen/greetd)       | A minimal, agnostic and flexible login manager daemon         | 🦀       |
| [greetd-tuigreet](https://github.com/apognu/tuigreet)   | A minimalistic text-based login screen for greetd             | 🦀       |
| [rofi](https://github.com/davatorium/rofi)              | A window switcher, application launcher and dmenu replacement | C        |
| [mako](https://github.com/emersion/mako)                | A lightweight Wayland notification daemon                     | C        |
| [grim](https://sr.ht/~emersion/grim/)                   | A screenshot utility for Wayland                              | C        |
| [slurp](https://github.com/emersion/slurp)              | A utility to select a region in a Wayland compositor          | C        |
| [wl-clipboard](https://github.com/bugaevc/wl-clipboard) | Command-line copy/paste utilities for Wayland                 | C        |
| [swaylock](https://github.com/swaywm/swaylock)          | Screen locker for Wayland                                     | C        |
| [swayidle](https://github.com/swaywm/swayidle)          | Idle management daemon for Wayland                            | C        |

For the command-line, a majority of the basic tools are replaced with Rust alternatives. Some of these have more features than their counterparts, or are just faster. 

| __CLI Tools__                                          | __Description__                                                                                           | Language |
|--------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|----------|
| [nushell](https://github.com/nushell/nushell)          | A shell with great error messages, but a bit unstable                                                     | 🦀       |
| [starship](https://github.com/starship/starship)       | A cross-shell prompt that is fast and customizable                                                        | 🦀       |
| [paru](https://github.com/Morganamilo/paru)            | An AUR helper and pacman wrapper written in Rust                                                          | 🦀       |
| [helix](https://github.com/helix-editor/helix)         | A modern vim-like terminal emulator                                                                       | 🦀       |
| [zellij](https://github.com/zellij-org/zellij)         | A terminal workspace, similar to tmux                                                                     | 🦀       |
| [eza](https://github.com/eza-community/eza)            | A `ls` replacement                                                                                        | 🦀       |
| [bat](https://github.com/sharkdp/bat)                  | A `cat` replacement                                                                                       | 🦀       |
| [fd](https://github.com/sharkdp/fd)                    | A `find` replacement                                                                                      | 🦀       |
| [zoxide](https://github.com/ajeetdsouza/zoxide)        | A `cd` replacement                                                                                        | 🦀       |
| [ripgrep-all](https://github.com/phiresky/ripgrep-all) | A `grep` replacement                                                                                      | 🦀       |
| [fzf](https://github.com/junegunn/fzf)                 | A fuzzy finder                                                                                            | Go       |
| [dua-cli](https://github.com/Byron/dua-cli)            | A `du` replacement                                                                                        | 🦀       |
| [duf](https://github.com/muesli/duf)                   | A `df` replacement                                                                                        | 🦀       |
| [bottom](https://github.com/ClementTsang/bottom)       | A `top` replacement                                                                                       | 🦀       |
| [procs](https://github.com/dalance/procs)              | A `ps` replacement                                                                                        | 🦀       |
| [git-delta](https://github.com/dandavison/delta)       | A `diff` replacement, also used with git                                                                  | 🦀       |
| [tlrc](https://github.com/tldr-pages/tlrc)             | Simplified and community-driven man pages. The rust client for [tldr](https://github.com/tldr-pages/tldr) | 🦀       |
| git                                                    | Version control system. Not using [gitoxide](https://github.com/Byron/gitoxide) yet.                      | C        |
| [chezmoi](https://github.com/twpayne/chezmoi)          | A dotfile manager written in Go                                                                           | Go       |
| [atuin](https://github.com/atuinsh/atuin)              | History management, with syncronization capabilities                                                      | 🦀       |
| [broot](https://github.com/Canop/broot)                | A terminal file navigator                                                                                 | 🦀       |
| [gitui](https://github.com/extrawurst/gitui)           | A terminal UI for git                                                                                     | 🦀       |


# To do
* [x] Debate whether to install atuin: https://github.com/atuinsh/atuin#nushell
* [x] See this nushell config: https://github.com/nullishamy/derivation-station/blob/master/users/amy/apps/tools/nu/config.nu#L1
* [x] Make nushell command to update system: sys_update = paru -Syu --noconfirm & rustup update
* [x] use Eww instead of waybar?
* [ ] xwaylandvideobridge should autostart on login
* [ ] fix dolphin thumbnails (need to get new theme for icons in general)
* [ ] fix lockscreen commands and stuff
* [ ] go to lockscreen on lid close and go to sleep (see https://wiki.archlinux.org/title/Power_management#ACPI_events)
* [ ] set brightness and volume keys
* [ ] fix poweroff, reboot, suspend, hibernate - for long press power button maybe turn off, otherwise sleep?
* [ ] show bluetooth, wifi, battery info in bar
* [ ] ripgrep-all with fzf? https://github.com/phiresky/ripgrep-all/wiki/fzf-Integration
* [ ] see this: https://github.com/quantonganh/helix-wezterm
* [ ] Change starship config location to ~/.config/starship/config.toml (export STARSHIP_CONFIG=~/.config/starship/config.toml)
* [ ] Find a display configurator (e.g., wdisplays), but make sure it works well on Hyprland
* [ ] brightnessctl ?
* [ ] https://github.com/coffebar/hyprland-monitor-attached
* [ ] chezmoi + command to commit changes
* Example: https://github.com/i4pg/dotfiles

# Left to config
* [x] bat: https://github.com/catppuccin/bat
* [x] fzf
* [x] rofi
* [ ] delta -- to do catppuccin theme manually
* [x] bottom
* [x] greetd
* [?] helix -- left to integrate with broot and gitui
* [x] gitui
* [?] broot -- left to integrate with helix
* [x] mako
* [x] atuin
* [?] hypr -- left integration with other apps: mako, swaylock, swayidle, brightnessctl, wl-clipboard?, grim, slurp
* [x] nushell
* [ ] swaylock
* [ ] eww
* [x] wezterm
* [x] zellij
* [x] starship