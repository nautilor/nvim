vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap

local opts = { noremap = true, silent = true }


-- x does not override yanked
keymap.set({ "n", "v" }, "x", '"_x', opts)

-- v does not override yanked
keymap.set("v", "p", ':call setreg("", @", "V") | put<Return>', opts)

-- Tabs
keymap.set("n", "<tab>", ":bnext<Return>", opts)
keymap.set("n", "<S-tab>", ":bprev<Return>", opts)
keymap.set("n", "<leader>bd", ":bd!<Return>", opts)

-- Terminal esc key
keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- Close
keymap.set("n", "<leader>q", ":q<Return>", opts)
keymap.set("n", "<leader>!", ":q!<Return>", opts)

-- Save
keymap.set("n", "<C-s>", ":w<Return>")

-- System clipboard
keymap.set({ "n", "v" }, "<C-y>", "\"+y")
keymap.set({ "n", "v" }, "<C-p>", "\"+p")

-- Disable F1 & q
keymap.set("n", "q", "")
keymap.set({ "n", "i" }, "<F1>", "")

-- reset the last search highlight
keymap.set("n", "<leader>/", ":nohlsearch<Return>", opts)

-- Line movement
keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv", opts)
keymap.set("v", "<C-Left>", "<gv", opts)
keymap.set("v", "<C-Right>", ">gv", opts)


-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")


-- Split
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
keymap.set("n", "wd", "<C-w><C-w>", opts)
keymap.set("n", "sd", "<C-w>q", opts)
keymap.set("n", "sk", ":bp | bd #<Return>", opts)
keymap.set("n", "<C-w>d", ":bp | bd #<Return>", opts)


-- Diagnostic
keymap.set("n", "<C-j>", vim.diagnostic.goto_next, opts)


-- LazyGit
keymap.set("n", "<C-l>", ":LazyGit<Return>", opts)


-- Telescope
keymap.set("n", "<leader><tab>", ":Telescope find_files<Return>", opts)
keymap.set("n", "<leader>fg", ":Telescope live_grep<Return>", opts)
keymap.set("n", "<leader>bb", ":Telescope buffers<Return>", opts)
keymap.set("n", "<leader>gd", ":Telescope lsp_definitions<Return>", opts)
keymap.set({ "i", "n" }, "<C-tab>", ":Telescope buffers<Return>", opts)
keymap.set({ "i", "n" }, "<C-o>", ":Telescope find_files<Return>", opts)
keymap.set({ "i", "n" }, "<C-f>", ":Telescope live_grep<Return>", opts)
keymap.set({ "i", "n" }, "<C-tab>", ":Telescope buffers<Return>", opts)
keymap.set({ "i", "n" }, "<C-g>", ":Telescope lsp_definitions<Return>", opts)
keymap.set({ "i", "n" }, "<C-f>", ":Telescope live_grep<Return>", opts)

-- NvimTree
keymap.set("n", "<leader>e", ":NvimTreeToggle<Return>", opts)
keymap.set({ "i", "n" }, "<C-b>", ":NvimTreeToggle<Return>", opts)

-- LSP
keymap.set("n", "<leader>r", vim.lsp.buf.rename)
keymap.set({ "n", "i" }, "<F2>", vim.lsp.buf.rename)

-- ToggleTerm
keymap.set({ "i", "n", "t" }, "<C-t>", "<cmd>ToggleTerm direction=float<Return>", opts)


-- GitSigns
keymap.set("n", "<leader>gp", ":Gitsign preview_hunk<Return>", opts)


-- Dired
function toggleDired()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local ft = vim.api.nvim_buf_get_option(buf, "filetype")
		if ft == "dired" then
			vim.cmd("DiredQuit")
			return
		end
	end
	vim.cmd("Dired")
end

keymap.set("n", "<C-n>", toggleDired, opts)
