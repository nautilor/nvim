-- Configure Mason ui
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})

-- Make sure that the lsp server are installed automatically
require("mason-lspconfig").setup({
	ensure_installed = {
		"pyright",
		"eslint"
	},
	automatic_installation = true,
})

-- Setup cmp for autocomplete while typing
local cmp = require("cmp")
cmp.setup({
	completion = {
		completeopt = "menu,menuone,preview,moselect"
	},
	sources = {
		{ name = "buffer" },
		{ name = "path" },
		{ name = "nvim_lsp"},
		{ name = "pyright" }
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		['<CR>'] = cmp.mapping.confirm({ select = true })
	}
})

-- Link cmp to lspconfig
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Configure all the lsp servers installed
local lspconfig = require("lspconfig")
lspconfig.pyright.setup({
	capabilities = capabilities
})

lspconfig.eslint.setup({
	capabilities = capabilities
})
