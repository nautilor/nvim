return {
	'stevearc/conform.nvim',
	init = function()
		local conform = require("conform")
		vim.keymap.set({"n", "v"}, "<leader>fc", function()
			conform.format({
				lsp_fallback = true,
				timeout_ms = 500
			})
		end)
	end,
	opts = {
		formatters_by_ft = {
			python = { "black" },
			typescript = {  'prettierd', "prettier", stop_after_first=true  },
			typescriptreact = { 'prettierd', "prettier", stop_after_first=true  },
			javascript = { 'prettierd', "prettier", stop_after_first=true  },
			javascriptreact = { 'prettierd', "prettier", stop_after_first=true  },
			json = { 'prettierd', "prettier", stop_after_first=true },
			html = { 'prettierd', "prettier", stop_after_first=true  },
			css = { 'prettierd', "prettier", stop_after_first=true  },
		},
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 500
		}
	}
}
