#!/bin/bash -i
# fail the script on any error and run script interactively
set -euo pipefail

prompt() {
  local label="$1"
  local default="$2"
  local input

  read -rp "$label [$default]: " input
  echo "${input:-$default}"
}

initial_setup() {
    echo "Updating pacman with 'pacman -Syu'"
    pacman -Syu --noconfirm
    echo "Installing sudo git base-devel"
    pacman -Sy --noconfirm sudo git base-devel
    echo "Setup password for 'root'"
    passwd
    echo "Creating user '$USERNAME'..."
    useradd -m -G wheel -s /bin/bash "$USERNAME"
    passwd "$USERNAME"
    echo "Enabling sudo for wheel group..."
    sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
}

install_paru() {
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
}

user_setup() {
    sudo -i -u "$USERNAME" bash << 'EOF'
    echo "Changing user"
    cd $HOME
    install_paru
    paru -Sy neovim wget
    exec bash
    EOF
}

USERNAME=$(prompt "Enter username" "user")
initial_setup
user_setup
