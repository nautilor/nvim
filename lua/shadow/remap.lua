vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<tab>", vim.cmd.bnext)
vim.keymap.set("n", "<S-tab>", vim.cmd.bprevious)
vim.keymap.set("n", "<leader>bd", ":bdelete!<CR>")
vim.keymap.set("n", "<leader>gg", ":edit term://lazygit<CR>")
vim.keymap.set("n", "<leader>tt", ":edit term://zsh<CR>")
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])




