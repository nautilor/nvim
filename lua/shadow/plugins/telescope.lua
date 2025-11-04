return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	init = function()
	end,
	opts = {
		defaults = {
			prompt_prefix = "   ",
			mappings = {
				n = {
					['<c-d>'] = require('telescope.actions').delete_buffer
				}, -- n
				i = {
					['<c-h>'] = "which_key",
					['<c-d>'] = require('telescope.actions').delete_buffer
				} -- i
			} -- mappings
		},
		pickers = {
			find_files = {
				hidden = true,
				file_ignore_patterns = { ".git/", "node_modules/" },
			},
			live_grep = {
				hidden = true,
				file_ignore_patterns = { ".git/", "node_modules/" },
			},
		},
	}
}
