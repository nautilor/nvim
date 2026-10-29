# Neovim Config

Personal Neovim config built on [lazy.nvim](https://github.com/folke/lazy.nvim). Lua only, namespace `shadow`. Focus: Java/Spring development, LSP, Snacks-based navigation, Tokyo Night-style UI.

Leader: `<Space>`. Local leader: `\`.

## Layout

```
init.lua                  leader, termguicolors, loads shadow.lazy
lua/shadow/
  lazy.lua                lazy.nvim bootstrap, loads shadow.plugins
  plugins/                one file per plugin spec
  core/
    config.lua            editor options
    remap.lua             global keymaps
    java_core.lua         Java run/test/debug workflow
    latex.lua             auto-compile .tex + mupdf viewer
    lsp_preview.lua       floating LSP preview (K)
    override/             lazygit + snacks theming
    plugins/noting/       local notes: header, links, checkboxes
    plugins/task/         per-project .task.md task manager
lazy-lock.json            pinned plugin versions
```

## Requirements

- Neovim 0.11+ (uses `vim.lsp.enable`, `vim.uv`)
- `git`, a Nerd Font, `ripgrep`
- Optional: `lazygit`, `latexmk` + `mupdf` (LaTeX), JDK + Maven/Gradle (Java), IntelliJ `idea` CLI (Java formatting), `prettierd`/`prettier`, `black`, `nixfmt`

## Install

```sh
git clone <repo> ~/.config/nvim
nvim   # lazy.nvim bootstraps and installs plugins
```

LSP servers and tools: install through `:Mason`.

## Plugins

| Area | Plugins |
|------|---------|
| Colors/UI | onedark.nvim (nautilor), lualine, markview, nvim-colorizer, tiny-inline-diagnostic |
| Navigation | snacks.nvim (picker, explorer, terminal, zen), mini.move |
| LSP/completion | nvim-lspconfig, mason, blink.cmp, copilot.vim |
| Syntax | nvim-treesitter, nvim-ts-autotag, nvim-autopairs |
| Formatting | conform.nvim |
| Git | lazygit.nvim, codediff.nvim |
| Java | nvim-java, spring-boot.nvim, nvim-dap, dap-ui, dap-virtual-text |
| Misc | timber.nvim (log helper), todo-comments, csvview, fold-imports |

### LSP servers enabled

`pyright`, `ts_ls`, `eslint`, `clangd`, `lua_ls`, `copilot_language_server`, `qmlls`, `rust_analyzer`, `dartls`, `nil`, `nixd`, `gopls`, `jdtls` (via nvim-java).

### Formatting

Format on save (500ms, LSP fallback).

- Java: IntelliJ (`idea format`), LSP fallback
- JS/TS/JSX/TSX/JSON/HTML/CSS: `prettierd` then `prettier`
- Python: `black`
- Nix: `nixfmt`

## Options

Relative + absolute line numbers, 2-space tabs, no swap/backup, cursorline on number only, `cmdheight=0`, custom listchars/fillchars (minimal borders).

## Keymaps

### General

| Key | Action |
|-----|--------|
| `jj` (insert) | Escape |
| `j` / `k` | Move and center |
| `<S-Down>` / `<S-Up>` | Move 3 lines |
| `<C-s>` | Save |
| `<C-y>` / `<C-p>` | Yank / paste system clipboard |
| `p` (visual) | Paste without clobbering register |
| `x` | Delete without yanking |
| `<C-/>` | Toggle comment |
| `<C-k>` | Toggle import folding (normal/visual) |
| `<Tab>` / `<S-Tab>` | Next / previous buffer |
| `<leader>bd` | Delete buffer |
| `<leader>/` | Clear search highlight |
| `<leader>q` / `<leader>!` | Quit / force quit |

### Windows

| Key | Action |
|-----|--------|
| `sv` / `ss` | Horizontal / vertical split |
| `sd`, `<C-w>c` | Smart close (window, or buffer if last) |
| `sk` | Close buffer, go to previous |

### Navigation (Snacks)

| Key | Action |
|-----|--------|
| `<C-o>` | Find files |
| `<C-f>` | Live grep |
| `q` | Buffers |
| `<leader>e` | Explorer |
| `<C-t>` | Toggle terminal |
| `<C-z>` | Zen mode |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Definitions |
| `gf` | References |
| `K` | Toggle floating preview |
| `<leader>r`, `<F2>` | Rename |
| `<C-j>` | Next diagnostic |

### Git

| Key | Action |
|-----|--------|
| `<C-l>` | LazyGit |
| `<leader>gd` | `CodeDiff HEAD` |

### Java

Active in Java buffers. Commands: `JavaRun`, `JavaRunSpring`, `JavaRunQuarkus`, `JavaRunTests`, `JavaToggleConsole`, `JavaStop`, `JavaSelectProfile`, `JavaAttachDebugger`, `JavaDebugMain`, `JavaBuildWorkspace`, `JavaRefreshMappers`.

| Key | Action |
|-----|--------|
| `<leader>jr` | Run app |
| `<leader>jb` | Run Spring Boot |
| `<leader>jq` | Run Quarkus |
| `<leader>jp` | Select profile |
| `<leader>jl` | Toggle console |
| `<leader>js` | Stop runner |
| `<leader>jt` / `jT` / `ja` | Test method / class / all |
| `<leader>jo` | Last test report |
| `<leader>jm` | Refresh MapStruct mappers |
| `<leader>dt` | Debug test method |
| `<leader>da` | Attach debugger (127.0.0.1:5005) |
| `<F5>` `<F9>` `<F10>` `<F11>` `<F12>` | DAP continue / breakpoint / over / into / out |
| `<leader>du`, `<leader>de` | DAP UI toggle / eval |

### Notes (Obsidian)

| Key | Action |
|-----|--------|
| `<leader>os` | Quick switch |
| `<leader>on` | New note |
| `<leader>oo` | cd to `~/.obsidian/Notes/` |
| `<leader>oc` | Toggle checkbox (inside a note) |

### Noting (local module)

Markdown notes under `~/.notes/` (created on startup). Keys are buffer-local in `.md` files inside that folder.

| Key | Action |
|-----|--------|
| `<leader>nh` | Insert `# Title` / `Created on: YYYY-MM-DD` header if missing (title from file name) |
| `<leader>nl` | Pick a note, insert `[](relative/path.md)`, cursor inside brackets in insert mode |
| `<leader>nc` | New `- [ ] ` checkbox, insert mode after it |
| `<CR>` | On a checkbox line: cycle `[ ]` → `[-]` → `[x]` |
| `gd` | Follow the markdown link under the cursor (falls back to LSP definition elsewhere) |

### Tasks

Per-git-project checklist stored as `.task.md` (default dir `~/.local/share/shadow-task`). Float keys: `<C-0>` open, `<C-9>` projects, `<leader>ta` annotate; inside float `<CR>` toggle, `<Tab>` cycle, `o`/`O` add, `dd` delete, `gd` jump.

## LaTeX

Opening a `.tex` buffer compiles with `latexmk -pdf` and opens/refreshes the PDF in `mupdf`.

## Notes

- Plugin versions pinned in `lazy-lock.json`; update with `:Lazy update`.
- Some UI colors (snacks picker, lualine) are derived from the onedark palette.
