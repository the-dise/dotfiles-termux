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
  relink "$OBJECT_DIR/confs/fastfetch/config.jsonc" ~/.config/fastfetch/config.jsonc
  chsh -s zsh
  exec zsh
  run_os_script
}

# Function to change the shell
switch_shell() {
  clear

  echo -e "\033[1;96mSelect Shell to Switch:\033[0m \n"
  echo "1) Zsh"
  echo "2) Bash"
  echo "0) Cancel "
  read -r -p $'\n\e[1;92mChoose Option: \e[0m' choice

  case $choice in
  1) switch_to_shell zsh ;;
  2) switch_to_shell bash ;;
  0) run_os_script ;;
  *) invalid_input ;;
  esac
}

# Function to handle actual shell switching
switch_to_shell() {
  local shell=$1
  if command -v "$shell" >/dev/null 2>&1; then
    if chsh -s "$shell"; then
      echo "Switched to $shell successfully."
      exec "$shell"
    else
      echo "Failed to switch to $shell. Please check your configuration or permissions."
    fi
  else
    echo "$shell is not installed."
  fi
}

install_nvim() {
  pkg install neovim
  git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
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
  if [ -d "$DOTFILES_DIR" ]; then
    rm -rf "$DOTFILES_DIR"
  fi
  git clone https://github.com/the-dise/dotfiles-termux "$DOTFILES_DIR"
  necessary_setup
  run_os_script
}

# Function to visit GitHub repository
visit_github() {
  echo "Opening GitHub repository..."
  termux-open "https://github.com/the-dise/dotfiles-termux"
}

# Function to show author repository and prompt to open Telegram channel
author() {
  clear
  echo -e " \e[1m$ the_dise █\e[0m \n"

  # Ask the user if they want to open the Telegram channel
  read -r -p "Visit the author's Telegram channel [Y/n]: " choice

  # Default to 'Y' if no input is provided
  choice=${choice:-Y}

  case $choice in
  [Yy]*)
    clear
    echo "Thanks thank you for your interest :)"
    sleep 2
    termux-open "https://t.me/thedise"
    ;;
  [Nn]*)
    clear
    echo " ___________"
    echo "| so sad :( |"
    echo "  ==========="
    echo "           \\"
    echo "            \\"
    echo "              ^__^"
    echo "              (oo)\_______"
    echo "              (__)\       )\/\\"
    echo "                  ||----w |"
    echo "                  ||     ||"
    ;;
  *)
    echo "Invalid input. Please enter Y or n."
    ;;
  esac
}

# Helper function to run os.sh script
run_os_script() {
  [ -f "$DOTFILES_DIR/setup.sh" ] && bash "$DOTFILES_DIR/setup.sh"
}

# Function to install everything with one command
install_all() {
  necessary_setup
  zsh_setup
  install_nvim
  install_nerd_font
  echo "All installations are complete."
}

# Menu function to display the options
menu() {
  cat <<EOF

 $ termux-dotfiles █
 ___________________

1) Necessary Setup
2) Install Everything
3) Zsh Setup
4) Install Nerd Font
5) Install Neovim
6) Switch Shell
7) Update Dotfiles
8) Visit GitHub
9) Author
0) Exit

EOF
  read -r -p $'\e[1;92mChoose Option: \e[0m' choice
  case $choice in
  1) necessary_setup ;;
  2) install_all ;;
  3) zsh_setup ;;
  4) install_nerd_font ;;
  5) install_nvim ;;
  6) switch_shell ;;
  7) update_dotfiles ;;
  8) visit_github ;;
  9) author ;;
  0) exit ;;
  *) invalid_input ;;
  esac
}

# Start the script by displaying the menu
menu
