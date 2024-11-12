return {
	'stevearc/oil.nvim',
	---@module 'oil'
	init = function()
		vim.keymap.set("n", "-", "<cmd>Oil<CR>")
	end,
	opts = {
		default_file_explorer = true,
		view_options = {
			show_hidden = true,
			natural_order = true,
			is_always_hidden = function(name, _)
				return name == ".git" or name == ".DS_Store" or name == ".." or name == "node_modules"
			end,
		}
	},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
