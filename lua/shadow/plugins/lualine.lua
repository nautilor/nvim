return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	init = function()
		vim.opt.laststatus = 3
	end,
	opts = {

		options = {
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			theme = 'gruvbox',
		},
		sections = {
			lualine_a = {
				{
					"mode",
					icon_enable = true,
					fmt = function()
						return vim.api.nvim_get_mode().mode == "t" and ""
								or ""
					end,
					separator = { left = "" }
				},
				{
					"mode",
					separator = { right = "" }
				}
			},
			lualine_b = {
				{
					"branch",
				},
				{
					"diff",
				}
			},
			lualine_c = {
			},
			lualine_x = {
			},
			lualine_y = {
				{ "filetype", colored = true, icon_only = true },
				"filename",
				'progress'
			},
			lualine_z = {
				{
					"selectioncount",
					fmt = function(count)
						if count == "" then
							return ""
						end
						return "[" .. count .. "]"
					end,
				},
				{
					"location",
					separator = { right = "", left = "" }
				},
			},
		},
		inactive_sections = {
			lualine_a = {
				{ "filetype", colored = true, icon_only = true, icon = { align = "right" } },
				"filename",
			},
			lualine_b = {
			},
			lualine_c = {},
			lualine_x = {},
			lualine_z = { "location" },
		},
	}
}
