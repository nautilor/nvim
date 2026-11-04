-- LSP configuration for Neovim

return {
	'neovim/nvim-lspconfig',
	dependencies = { 'saghen/blink.cmp' },
	config = function()
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" }
					}
				}
			}
		})

		vim.lsp.enable({
			"pyright",
			"ts_ls",
			"eslint",
			"clangd",
			"lua_ls",
			"copilot_language_server",
			"qmlls",
			"rust_analyzer",
			"dartls",
			"nil",
			"nixd",
			"gopls"
		})
	end
}
