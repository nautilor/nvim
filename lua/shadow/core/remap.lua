vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap

local opts = { remap = true, silent = true }
local nopts = { noremap = true, silent = true }


-- Move X lines when using shift+down/up
keymap.set({ "n", "v" }, "<S-Down>", "3j", opts)
keymap.set({ "n", "v" }, "<S-Up>", "3k", opts)

-- Comment code
keymap.set("n", "<C-_>", "gcc", opts)
keymap.set("v", "<C-_>", "gc", opts)
keymap.set("n", "<C-/>", "gcc", opts)
keymap.set("v", "<C-/>", "gc", opts)

-- x does not override yanked
keymap.set({ "n", "v" }, "x", '"_x', nopts)

-- v does not override yanked
keymap.set("v", "p", ':call setreg("", @", "V") | put<Return>', nopts)

-- Tabs
keymap.set("n", "<tab>", ":bnext<Return>", nopts)
keymap.set("n", "<S-tab>", ":bprev<Return>", nopts)
keymap.set("n", "<leader>bd", ":bd!<Return>", nopts)

-- Terminal esc key
keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- Close
keymap.set("n", "<leader>q", ":q<Return>", nopts)
keymap.set("n", "<leader>!", ":q!<Return>", nopts)

-- Save
keymap.set("n", "<C-s>", ":w<Return>")

-- System clipboard
keymap.set({ "n", "v" }, "<C-y>", "\"+y")
keymap.set({ "n", "v" }, "<C-p>", "\"+p")

-- Disable F1 & q
keymap.set("n", "q", "")
keymap.set({ "n", "i" }, "<F1>", "")

-- Reset the last search highlight
keymap.set("n", "<leader>/", ":nohlsearch<Return>", nopts)

-- Line movement
keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv", nopts)
keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv", nopts)
keymap.set("v", "<C-Left>", "<gv", nopts)
keymap.set("v", "<C-Right>", ">gv", nopts)


-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")


-- Split
keymap.set("n", "ss", ":split<Return>", nopts)
keymap.set("n", "sv", ":vsplit<Return>", nopts)
keymap.set("n", "wd", "<C-w><C-w>", nopts)
keymap.set("n", "sd", "<C-w>q", nopts)
keymap.set("n", "sk", ":bp | bd #<Return>", nopts)
keymap.set("n", "<C-w>d", ":bp | bd #<Return>", nopts)


-- Diagnostic
keymap.set("n", "<C-j>", vim.diagnostic.goto_next, nopts)


-- LazyGit
keymap.set("n", "<C-l>", ":LazyGit<Return>", nopts)

-- Go back and forward from jumps
keymap.set("n", "<C-w>b", "<C-o>", nopts)
keymap.set("n", "<C-w>f", "<C-i>", nopts)

-- Snacks Picker
keymap.set({ "i", "n" }, "<C-o>", function() require("snacks").picker.files() end, nopts)
keymap.set({ "i", "n" }, "<C-f>", function() require("snacks").picker.grep() end, nopts)
keymap.set("n", "<leader>bb", function() require("snacks").picker.buffers() end, nopts)

-- Snacks LSP
keymap.set("n", "<leader>gd", function() require("snacks").picker.lsp_definitions() end, nopts)
keymap.set("n", "<leader>gf", function() require("snacks").picker.lsp_references() end, nopts)

-- Snacks Zen
keymap.set("n", "<leader>fm", function() require("snacks").zen() end, nopts)

-- ToggleTerm
keymap.set({ "n", "v", "t", "i" }, "<C-t>", ":ToggleTerm direction=float<Return>", nopts)

-- NvimTree
keymap.set("n", "<leader>e", ":NvimTreeToggle<Return>", nopts)
keymap.set({ "i", "n" }, "<C-b>", ":NvimTreeToggle<Return>", nopts)

-- LSP
keymap.set("n", "<leader>r", vim.lsp.buf.rename)
keymap.set({ "n", "i" }, "<F2>", vim.lsp.buf.rename)

-- GitSigns
keymap.set("n", "<leader>gp", ":Gitsign preview_hunk<Return>", nopts)


-- Obsidian
keymap.set("n", "<leader>os", ":Obsidian quick_switch<CR>")
keymap.set("n", "<leader>on", ":Obsidian new<CR>")
keymap.set("n", "<leader>oo", ":cd ~/.obsidian/Notes/<CR>")
vim.api.nvim_create_autocmd("User", {
	pattern = "ObsidianNoteEnter",
	callback = function()
		keymap.set("n", "<leader>oc", ":Obsidian toggle_checkbox<CR>")
	end
})
