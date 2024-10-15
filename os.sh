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
  selection
}

# Function to perform the setup
necessary_setup() {
  termux-setup-storage
  apt update && apt upgrade -y
  pkg install -y wget curl git zsh starship fzf eza neovim fastfetch ripgrep zip unzip htop openssh

  # Configure termux properties
  rm -f ~/.termux/colors.properties
  rm -f /data/data/com.termux/files/usr/etc/motd
  relink "$OBJECT_DIR/.colors.properties" ~/.termux/colors.properties
  relink "$OBJECT_DIR/.termux.properties" ~/.termux/termux.properties

  run_os_script
}

# Function for Zsh setup
zsh_setup() {
  rm -rf ~/.zshrc
  pkg install starship
  relink "$OBJECT_DIR/.zshrc" ~/.zshrc
  relink "$OBJECT_DIR/zsh/starship/starship.toml" ~/.config/starship.toml
  run_os_script
}

# Function to change shell
switch_shell() {
  local shell=$1
  chsh -s "$shell"
  run_os_script
}

# Function to install a Nerd Font
install_nerd_font() {
  # Clone the Nerd Font installer repository
  pkg install clang
  git clone https://github.com/notflawffles/termux-nerd-installer.git
  cd termux-nerd-installer || return

  # Install dependencies and the specified font
  make install
  termux-nerd-installer i jetbrains-mono-ligatures
  termux-nerd-installer set jetbrains-mono-ligatures
  run_os_script
}

# Function to update dotfiles-termux
update_dotfiles() {
  rm -rf "$DOTFILES_DIR"
  git clone https://github.com/the-dise/dotfiles-termux "$DOTFILES_DIR"
  run_os_script
}

# Helper function to run os.sh script
run_os_script() {
  bash "$DOTFILES_DIR/os.sh"
}

# Selection function to handle user input
selection() {
  echo -e -n "\e[1;96m Choose Option : \e[0m"
  read -r choice
  case $choice in
  1) necessary_setup ;;
  2) zsh_setup ;;
  3) switch_shell zsh ;;
  4) switch_shell bash ;;
  5) update_dotfiles ;;
  6) install_nerd_font ;;
  0) exit ;;
  *) invalid_input ;;
  esac
}

# Menu function to display the options
menu() {
  printf "\n\033[1;91m[\033[0m1\033[1;91m]\033[1;92m Necessary Setup \n"
  printf "\033[1;91m[\033[0m2\033[1;91m]\033[1;92m Zsh Setup\n"
  printf "\033[1;91m[\033[0m3\033[1;91m]\033[1;92m Switch to Zsh Shell\n"
  printf "\033[1;91m[\033[0m4\033[1;91m]\033[1;92m Switch to Bash Shell\n"
  printf "\033[1;91m[\033[0m5\033[1;91m]\033[1;92m Install Nerd Font\n"
  printf "\033[1;91m[\033[0m6\033[1;91m]\033[1;92m Update\n"
  printf "\033[1;91m[\033[0m0\033[1;91m]\033[1;92m Exit\n\n\n"

  selection
}

# Run the menu
menu
