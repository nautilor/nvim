# Neovim Configuration

Welcome to my Neovim configuration! This setup is designed to enhance your coding experience with powerful plugins and a beautiful interface.

## Table of Contents

- [Installation](#installation)
- [Plugins](#plugins)
- [Configuration](#configuration)
- [Key Bindings](#key-bindings)
- [Contributing](#contributing)
- [License](#license)

## Installation

To get started with this Neovim configuration, follow these steps:

1. **Clone the repository:**

   ```sh
   git clone https://github.com/nautilor/nvim.git ~/.config/nvim
   ```

2. **Install the dependencies:**

   This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) for managing plugins. The bootstrap process is handled in [lua/shadow/lazy.lua](lua/shadow/lazy.lua).

3. **Open Neovim:**

   ```sh
   nvim
   ```

## Plugins

Here are some of the key plugins included in this configuration:

- **[alpha-nvim](https://github.com/goolord/alpha-nvim):** A fast and fully programmable greeter for Neovim.
- **[onedark.nvim](https://github.com/navarasu/onedark.nvim):** A dark color scheme for Neovim.
- **[mason.nvim](https://github.com/williamboman/mason.nvim):** A package manager for Neovim.
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig):** Quickstart configurations for the Neovim LSP client.
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter):** Treesitter configurations and abstraction layer for Neovim.

For a full list of plugins, check out the [plugins directory](lua/shadow/plugins).

## Configuration

The main configuration files are located in the `lua/shadow/core` directory:

- **[config.lua](lua/shadow/core/config.lua):** General settings and options.
- **[init.lua](lua/shadow/core/init.lua):** Entry point for the configuration.
- **[remap.lua](lua/shadow/core/remap.lua):** Key mappings.

## Key Bindings

Please take a look at the [KEYMAP](KEYMAP.md) file

## Contributing

Contributions are welcome! Please open an issue or submit a pull request on GitHub.
