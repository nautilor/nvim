vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<tab>", vim.cmd.bnext)
vim.keymap.set("n", "<S-tab>", vim.cmd.bprevious)
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete!<CR>")
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
vim.keymap.set("i", "jj", "<ESC>", { silent = true })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")
vim.keymap.set("n", "<leader>!", "<cmd>q!<CR>")
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>")
vim.keymap.set("n", "<leader>sv", "<cmd>source $MYVIMRC<CR>")
vim.keymap.set("n", "<C-j>", "i")
vim.keymap.set("n", "<C-y>", "\"+y")
vim.keymap.set("n", "<C-p>", "\"+p")
vim.keymap.set("v", "<C-y>", "\"+y")
vim.keymap.set("v", "<C-p>", "\"+p")
