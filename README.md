# Termux Setup Script

This script provides a streamlined setup process for the Termux environment on Android. It allows users to configure their Termux installation by installing essential packages, setting up the shell environment, and managing dotfiles with ease.

## Features

- **Easy Setup**: Quickly install necessary packages for a productive Termux environment.
- **Shell Configuration**: Switch between Zsh and Bash shells with a single command.
- **Font Installation**: Install and set up Nerd Fonts for improved terminal aesthetics.
- **Neovim Setup**: Install Neovim with the nvChad configuration for an enhanced coding experience.
- **Dotfile Management**: Automatically link and manage dotfiles for consistent configurations.

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/the-dise/dotfiles-termux.git
   ```

2. Navigate to the script directory:

   ```bash
   cd ~/.dotfiles-termux
   ```

3. Make the script executable:

   ```bash
   chmod +x setup.sh
   ```

4. Run the script:

   ```bash
   ./setup.sh
   ```

## One-Line Installation

You can install everything with a single command:

```bash
git clone https://github.com/the-dise/dotfiles-termux.git && cd dotfiles-termux && chmod +x setup.sh && ./setup.sh
```

## Usage

After running the script, a menu will appear with the following options:

1. Necessary Setup
2. Zsh Setup
3. Switch Shell
4. Install Everything (All setups at once)
5. Install Nerd Font
6. Install Neovim and nvChad
9. Reload Settings
0. Exit

Simply enter the number corresponding to the desired option and follow the prompts.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Termux](https://termux.com/) - A powerful terminal emulator for Android.
- [Neovim](https://neovim.io/) - A hyperextensible Vim-based text editor.
- [nvChad](https://nvchad.com/) - Blazing fast Neovim config providing solid defaults and a beautiful UI.
- [Nerd Fonts](https://www.nerdfonts.com/) - Patched fonts for developers.