vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- navigate between buffers and close them
vim.keymap.set("n", "<tab>", vim.cmd.bnext)
vim.keymap.set("n", "<S-tab>", vim.cmd.bprevious)
vim.keymap.set("n", "<leader>bd", "<cmd>bd!<CR>")

-- handle escape key while on terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")
vim.keymap.set("n", "<leader>!", "<cmd>q!<CR>")
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>")

-- copy/paste to/from the system clipboard
vim.keymap.set({ "n", "v" }, "<C-y>", "\"+y")
vim.keymap.set({ "n", "v" }, "<C-p>", "\"+p")

-- remove the keymap q and F1
vim.keymap.set("n", "q", "")
vim.keymap.set({ "n", "i" }, "<F1>", "")

-- reset the last search highlight
vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<CR>")

-- easier to move selected lines
vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-Left>", "<gv")
vim.keymap.set("v", "<C-Right>", ">gv")
