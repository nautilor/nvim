vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pf", vim.cmd.Ex)
vim.keymap.set("n", "<tab>", vim.cmd.bnext)
vim.keymap.set("n", "<S-tab>", vim.cmd.bprevious)
vim.keymap.set("n", "<leader>bd", ":bdelete!<CR>")
vim.keymap.set("n", "<leader>gg", ":edit term://lazygit<CR>")
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
