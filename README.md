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

| Mode              | Keybind              | Command                                                    |
| ----------------- | -------------        | ---------------------------------------------------------- |
| "n"               | "\<leader>r"         | vim.lsp.buf.rename                                         |
| "n"               | "\<leader>e"         | "\<cmd>NvimTreeToggle\<CR>"                                |
| "n"               | "\<leader>hh"        | "\<cmd>lua require("harpoon.mark").add_file()\<CR>"        |
| "n"               | "\<leader>mm"        | "\<cmd>lua require("harpoon.ui").toggle_quick_menu()\<CR>" |
| "n"               | "\<leader>nn"        | "\<cmd>lua require("harpoon.ui").nav_next()\<CR>"          |
| "n"               | "\<leader>pp"        | "\<cmd>lua require("harpoon.ui").nav_prev()\<CR>"          |
| "n"               | "-"                  | "\<cmd>Oil\<CR>"                                           |
| "n"               | "\<leader>gp"        | "\<cmd>Gitsign preview_hunk\<CR>"                          |
| {"n", "v"}        | "\<leader>fc"        | function                                                   |
| "n"               | "\<leader>\<tab>"    | "\<cmd>Telescope find_files\<CR>"                          |
| "n"               | "\<leader>fg"        | "\<cmd>Telescope live_grep\<CR>"                           |
| "n"               | "\<leader>bb"        | "\<cmd>Telescope buffers\<CR>"                             |
| "n"               | "\<leader>gd"        | "\<cmd>Telescope lsp_definitions\<CR>"                     |
| "n"               | "\<leader>\<leader>" | "\<cmd>Telescope oldfiles\<CR>"                            |
| { "i", "n" }      | "\<C-o>"             | "\<cmd>Telescope find_files\<CR>"                          |
| { "i", "n" }      | "\<C-f>"             | "\<cmd>Telescope live_grep\<CR>"                           |
| { "i", "n" }      | "\<C-b>"             | "\<cmd>Telescope buffers\<CR>"                             |
| { "i", "n" }      | "\<C-g>"             | "\<cmd>Telescope lsp_definitions\<CR>"                     |
| "n"               | "\<leader>tt"        | "\<cmd>ToggleTerm direction=float\<CR>"                    |
| { "i", "n", "t" } | "\<C-t>"             | "\<cmd>ToggleTerm direction=float\<CR>"                    |
| "n"               | "\<tab>"             | vim.cmd.bnext                                              |
| "n"               | "\<S-tab>"           | vim.cmd.bprevious                                          |
| "n"               | "\<leader>bd"        | "\<cmd>bdelete!\<CR>"                                      |
| "t"               | "\<Esc>"             | [[<C-\\>\<C-n>]]                                           |
| "i"               | "jj"                 | "\<ESC>", { silent = true }                                |
| "n"               | "\<leader>q"         | "\<cmd>q\<CR>"                                             |
| "n"               | "\<leader>!"         | "\<cmd>q!\<CR>"                                            |
| "n"               | "\<C-s>"             | "\<cmd>w\<CR>"                                             |
| "n"               | "\<leader>sv"        | "\<cmd>source $MYVIMRC\<CR>"                               |
| "n"               | "\<C-j>"             | "i"                                                        |
| "n"               | "\<C-y>"             | "\\"+y"                                                    |
| "n"               | "\<C-p>"             | "\\"+p"                                                    |
| "v"               | "\<C-y>"             | "\\"+y"                                                    |
| "v"               | "\<C-p>"             | "\\"+p"                                                    |
| "n"               | "\<C-l>"             | "\<cmd>LazyGit\<CR>"                                       |

## Contributing

Contributions are welcome! Please open an issue or submit a pull request on GitHub.
