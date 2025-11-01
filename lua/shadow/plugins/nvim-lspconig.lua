return {
	'neovim/nvim-lspconfig',
	dependencies = { 'saghen/blink.cmp' },
	init = function()
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
	end,
	config = function()
		vim.lsp.enable({
			"pyright",
			"ts_ls",
			"eslint",
			"clangd",
			"lua_ls"
		})
	end
}
