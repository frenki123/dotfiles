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
    echo "Creating user '$USERNAME'..."
    useradd -m -G wheel -s /bin/bash "$USERNAME"
    passwd "$USERNAME"
    echo "Enabling sudo for wheel group..."
    sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
}

change_user() {
    su $USERNAME
    echo "Changing user"
    cd $HOME
}

USERNAME=$(prompt "Enter username" "user")
initial_setup
