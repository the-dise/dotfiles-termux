#!/bin/bash

clear

# Define common paths
DOTFILES_DIR="$HOME/.dotfiles-termux"
OBJECT_DIR="$DOTFILES_DIR/.object"

relink() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"
  rm -rf "$dst"
  ln -s "$src" "$dst"
}

# Function for invalid input handling
invalid_input() {
  printf "\033[1;91m Invalid input!\n"
  menu
}

# Function for initial setup
necessary_setup() {
  termux-setup-storage
  apt update && apt upgrade -y

  # Install packages
  pkg install -y wget termux-api curl git zsh starship fzf eza neovim \
    fastfetch ripgrep zip unzip htop openssh

  # Configure Termux properties
  rm -f ~/.termux/colors.properties
  rm -f ~/.termux/termux.properties
  rm -f /data/data/com.termux/files/usr/etc/motd
  relink "$OBJECT_DIR/colors.properties" ~/.termux/colors.properties
  cp "$OBJECT_DIR/termux.properties" ~/.termux/termux.properties

  run_os_script
}

# Function for Zsh setup
zsh_setup() {
  pkg install -y zsh starship
  rm -f ~/.zshrc
  relink "$OBJECT_DIR/.zshrc" ~/.zshrc
  relink "$OBJECT_DIR/zsh/starship/starship.toml" ~/.config/starship.toml
  relink "$OBJECT_DIR"/confs/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
  chsh -s zsh
  exec zsh
  run_os_script
}

# Function to change the shell
switch_shell() {
  local shell=$1
  if command -v "$shell" >/dev/null 2>&1; then
    if chsh -s "$shell"; then
      echo "Switched to $shell successfully."
      # Launch the new shell to take effect immediately
      exec "$shell"
    else
      echo "Failed to switch to $shell. Please check your configuration or permissions."
    fi
  else
    echo "$shell is not installed."
  fi
}

# Function to install a Nerd Font
install_nerd_font() {
  pkg install make clang -y
  # Clone the Nerd Font installer repository if not already present
  [ ! -d "~/termux-nerd-installer" ] && git clone https://github.com/notflawffles/termux-nerd-installer.git ~/termux-nerd-installer
  cd ~/termux-nerd-installer || return 1

  # Install the specified font
  make install && termux-nerd-installer i jetbrains-mono-ligatures &&
    termux-nerd-installer set jetbrains-mono-ligatures
  cd ..
  rm -rf ~/termux-nerd-installer
  run_os_script
}

# Function to update dotfiles-termux
update_dotfiles() {
  # if [ -d "$DOTFILES_DIR" ]; then
  #   rm -rf "$DOTFILES_DIR"
  # fi
  # git clone https://github.com/the-dise/dotfiles-termux "$DOTFILES_DIR"
  # necessary_setup
  # run_os_script
  termux-reload-settings
  run_os_script
}

# Helper function to run os.sh script
run_os_script() {
  [ -f "$DOTFILES_DIR/os.sh" ] && bash "$DOTFILES_DIR/os.sh"
}

# Menu function to display the options
menu() {
  cat <<EOF

the_dise's termux dotfiles

===

1) Necessary Setup
2) Zsh Setup
3) Switch to Zsh Shell
4) Switch to Bash Shell
5) Install Nerd Font
9) Reload settings
0) Exit

EOF
  read -r -p $'\e[1;96mChoose Option: \e[0m' choice
  case $choice in
  1) necessary_setup ;;
  2) zsh_setup ;;
  3) switch_shell zsh ;;
  4) switch_shell bash ;;
  5) install_nerd_font ;;
  9) update_dotfiles ;;
  0) exit ;;
  *) invalid_input ;;
  esac
}

# Start the script by displaying the menu
menu
