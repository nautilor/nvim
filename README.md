# Neovim Configuration

My personal Neovim configuration built with [lazy.nvim](https://github.com/folke/lazy.nvim), focused on a modern editing experience with LSP support, fast navigation, and a clean UI.

## Table of Contents

- [Installation](#installation)
- [Structure](#structure)
- [Plugins](#plugins)
- [Customizations](#customizations)
- [Key Bindings](#key-bindings)

## Installation

1. **Clone the repository:**

   ```sh
   git clone https://github.com/nautilor/nvim.git ~/.config/nvim
   ```

2. **Open Neovim** — lazy.nvim bootstraps itself automatically on first launch:

   ```sh
   nvim
   ```

## Structure

```
~/.config/nvim/
├── init.lua                   # Entry point — sets leader keys, enables true colors
├── lazy-lock.json             # Plugin lockfile
└── lua/shadow/
    ├── lazy.lua               # lazy.nvim bootstrap & plugin discovery
    ├── core/
    │   ├── init.lua           # Loads all core modules
    │   ├── config.lua         # Editor options & settings
    │   ├── remap.lua          # Keybindings
    │   ├── latex.lua          # LaTeX auto-compilation setup
    │   └── override/
    │       ├── lazygit.lua    # LazyGit window customization
    │       └── snack.lua      # Custom Snacks.nvim theming
    └── plugins/               # One file per plugin configuration
```

## Plugins

### UI & Colorscheme

| Plugin | Description |
|--------|-------------|
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Tokyo Night color scheme (night variant, transparent background) |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line with branch, diff, filename, progress, and selection count |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | UI toolkit: dashboard, file picker, explorer, zen mode, indent guides, smooth scroll, word highlighting |
| [markview.nvim](https://github.com/OXY2DEV/markview.nvim) | Enhanced Markdown rendering |
| [tiny-inline-diagnostic.nvim](https://github.com/rachartier/tiny-inline-diagnostic.nvim) | Inline LSP diagnostics |
| [nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua) | Highlights color codes (RGB, hex, CSS functions) inline |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File type icons |
| [mini.icons](https://github.com/echasnovski/mini.icons) | Additional icon support |

### LSP & Completion

| Plugin | Description |
|--------|-------------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configurations (pyright, ts_ls, eslint, clangd, lua_ls, rust_analyzer, dartls, qmlls, copilot) |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Package manager for LSP servers, linters, and formatters |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Bridges mason and lspconfig |
| [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) | Full Java LSP support with debug adapter (Java SE-21, Gradle/Maven) |
| [blink.cmp](https://github.com/Saghen/blink.cmp) | Fast completion engine with LSP, path, and buffer sources; super-tab navigation |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Curated snippet collection |

### Syntax & Formatting

| Plugin | Description |
|--------|-------------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Tree-sitter syntax highlighting and indentation (Java, Python, C, Lua, JS/TS, Rust, Dart, Bash, Markdown, Dockerfile) |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Format on save — Black (Python), Prettier (JS/TS/JSON/HTML/CSS) |

### Editing

| Plugin | Description |
|--------|-------------|
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-closes brackets and quotes |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Auto-closes and renames HTML tags |
| [mini.move](https://github.com/echasnovski/mini.move) | Move lines/selections with `Ctrl+Arrow` |
| [multicursor.nvim](https://github.com/jake-stewart/multicursor.nvim) | Multi-cursor editing |
| [timber.nvim](https://github.com/Goose97/timber.nvim) | Smart debug log insertion |

### Navigation

| Plugin | Description |
|--------|-------------|
| [oil.nvim](https://github.com/stevearc/oil.nvim) | File explorer as a buffer |

### Git

| Plugin | Description |
|--------|-------------|
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | LazyGit floating window integration |
| [git-blame.nvim](https://github.com/f-person/git-blame.nvim) | Inline git blame annotations |
| [vscode-diff.nvim](https://github.com/vim-scripts/vscode-diff.nvim) | VSCode-style diff viewer (`:CodeDiff <file> HEAD`) |

### Terminal

| Plugin | Description |
|--------|-------------|
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Floating terminal toggle |

### Productivity

| Plugin | Description |
|--------|-------------|
| [copilot.vim](https://github.com/github/copilot.vim) | GitHub Copilot AI completions |
| [obsidian.nvim](https://github.com/epwalsh/obsidian.nvim) | Obsidian vault integration (`~/.obsidian/Notes`) |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlights TODO/FIXME/NOTE/HACK comments |

### Libraries

| Plugin | Description |
|--------|-------------|
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Lua utility library |
| [nui.nvim](https://github.com/MunifTanjim/nui.nvim) | UI component library |

## Customizations

### Editor Settings

| Option | Value | Description |
|--------|-------|-------------|
| `number` | `true` | Show absolute line numbers |
| `relativenumber` | `true` | Show relative line numbers |
| `tabstop` / `shiftwidth` | `2` | 2-space indentation |
| `cursorline` | `true` (number only) | Highlight only the line number of the cursor line |
| `swapfile` / `backup` | `false` | No swap or backup files |
| `conceallevel` | `1` | Partial concealing (used by Markdown/Obsidian) |
| `cmdheight` | `0` | Hide the command line when not in use |
| `termguicolors` | `true` | Enable 24-bit color |

**Leader key:** `Space` · **Local leader:** `\`

### Colorscheme

- **Theme:** Tokyo Night (`night` variant) with a transparent background
- **Borders:** Blue (`#7AA2F7`)
- **Floats:** Dark background, no transparency
- **Snacks picker/input:** Custom-themed with Tokyo Night Moon palette

### Status Line (lualine)

- **Theme:** Tokyo Night
- **Left:** Mode icon → git branch → diff stats
- **Right:** `parent/filename` → scroll progress → selection count → cursor position

### Dashboard

Custom ASCII Neovim logo with quick-access keybinds and a live `git status --short --branch` section.

### LaTeX Auto-compilation

When editing `*.tex` files, `<leader>lc` toggles an automatic `latexmk -pdf` compiler that runs on open and on save. The PDF is opened in **mupdf** and reloaded automatically via `SIGHUP`.

### Formatters (conform.nvim)

| Language | Formatter |
|----------|-----------|
| Python | `black` |
| JS / TS / TSX | `prettierd` → `prettier` (fallback) |
| JSON / HTML / CSS | `prettierd` → `prettier` (fallback) |

Format on save is enabled with a 500 ms timeout and falls back to the LSP formatter.

## Key Bindings

### General

| Key | Action | Mode |
|-----|--------|------|
| `jj` | Exit insert mode | Insert |
| `<C-s>` | Save file | Normal / Insert |
| `<leader>q` | Quit | Normal |
| `<leader>!` / `<leader>1` | Force quit | Normal |
| `<F1>` | Disabled | Normal / Insert |
| `q` | Disabled (prevents accidental macro recording) | Normal |

### Navigation

| Key | Action | Mode |
|-----|--------|------|
| `j` / `k` | Move down/up (view centered) | Normal |
| `<S-Down>` / `<S-Up>` | Move 3 lines down/up | Normal / Visual |
| `<tab>` | Next buffer | Normal |
| `<S-tab>` | Previous buffer | Normal |
| `<leader>bd` | Delete buffer | Normal |

### Windows & Splits

| Key | Action | Mode |
|-----|--------|------|
| `sv` | Horizontal split | Normal |
| `ss` | Vertical split | Normal |
| `sd` | Close split | Normal |
| `sk` | Close buffer, keep split | Normal |
| `<C-w>c` | Smart close (window or buffer) | Normal |

### Clipboard

| Key | Action | Mode |
|-----|--------|------|
| `<C-y>` | Copy to system clipboard | Normal / Visual |
| `<C-p>` | Paste from system clipboard | Normal / Visual / Select |
| `x` | Delete without yanking | Normal / Visual |
| `p` | Paste without overwriting register | Visual |

### Search & Picker

| Key | Action | Mode |
|-----|--------|------|
| `<leader>/` | Clear search highlight | Normal |
| `<C-o>` | File picker (Snacks) | Normal |
| `<C-b>` | Buffer picker (Snacks) | Normal |
| `<C-f>` | Live grep (Snacks) | Normal |
| `<leader>e` | File explorer (Snacks) | Normal |
| `<leader>w` | Oil file explorer | Normal |

### LSP

| Key | Action | Mode |
|-----|--------|------|
| `gd` | Go to definition | Normal |
| `gf` | Show references | Normal |
| `<leader>r` / `<F2>` | Rename symbol | Normal |
| `<C-j>` | Next diagnostic | Normal |

### Commenting

| Key | Action | Mode |
|-----|--------|------|
| `<C-/>` | Toggle line comment | Normal / Visual |
| `<C-_>` | Toggle comment (terminal fallback) | Visual |

### Git

| Key | Action | Mode |
|-----|--------|------|
| `<C-l>` | Open LazyGit | Normal |
| `<leader>gd` | Diff current file vs HEAD | Normal |

### Terminal

| Key | Action | Mode |
|-----|--------|------|
| `<C-t>` | Toggle floating terminal | Normal / Visual / Insert / Terminal |
| `<Esc>` | Exit terminal mode | Terminal |

### Multi-cursor

| Key | Action |
|-----|--------|
| `<C-LeftMouse>` | Add cursor at click position |
| `<C-n>` | Enable / add cursor |
| `n` / `N` | Add cursor on next/previous match |
| `q` / `Q` | Skip next/previous match |
| `<leader>x` | Delete main cursor |
| `<Esc>` | Clear all extra cursors |

### Text Movement (mini.move)

| Key | Action | Mode |
|-----|--------|------|
| `<C-Left>` / `<C-Right>` | Move character/selection left/right | Normal / Visual |
| `<C-Down>` / `<C-Up>` | Move line/selection down/up | Normal / Visual |

### Debug Logging (timber.nvim)

| Key | Action |
|-----|--------|
| `glj` | Insert log statement below |
| `glk` | Insert log statement above |
| `glo` / `glp` | Insert plain log |
| `gla` | Add to batch log |
| `glc` | Print batch log |

### Zen Mode

| Key | Action |
|-----|--------|
| `<C-z>` | Toggle Zen mode |

### Obsidian

| Key | Action |
|-----|--------|
| `<leader>os` | Quick switch notes |
| `<leader>on` | New note |
| `<leader>oo` | Open Notes directory |
| `<leader>oc` | Toggle checkbox |

### LaTeX

| Key | Action |
|-----|--------|
| `<leader>lc` | Toggle LaTeX auto-compiler |

### Diff Viewer (vscode-diff)

| Key | Action |
|-----|--------|
| `q` | Close diff |
| `<leader>e` | Toggle file tree |
| `<tab>` | Switch diff pane |
| `]f` / `[f` | Next / previous file |
| `]c` / `[c` | Next / previous hunk |
