return {
	'neovim/nvim-lspconfig',
	dependencies = { 'saghen/blink.cmp' },
	init = function()
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
	end,
	config = function()
		local lspconfig = require('lspconfig')
		local blink = require("blink.cmp")
		lspconfig.pyright.setup({
			capabilities = blink.get_lsp_capabilities(lspconfig.pyright.capabilities)
		})
		lspconfig.eslint.setup({
			capabilities = blink.get_lsp_capabilities(lspconfig.eslint.capabilities)
		})
		lspconfig.ts_ls.setup({
			capabilities = blink.get_lsp_capabilities(lspconfig.ts_ls.capabilities)
		})
		lspconfig.lua_ls.setup({
			capabilities = blink.get_lsp_capabilities(lspconfig.lua_ls.capabilities),
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' }
					}
				}
			}
		})
	end
}
