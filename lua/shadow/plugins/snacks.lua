return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type table
	opts = {
		input = { enabled = false },
		terminal = { enabled = false },
		notifier = { enabled = false },
		scope = { enabled = false },
		-- <-----------------------> --
		dashboard = {
			enabled = true,
			preset = {
				header = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⡶⠿⠿⠷⣶⣄⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡿⠁⠀ ⠀⣠⡀⠙⣷⡀⠀⠀⠀
⠀⠀⠀⡀⠀⠀⠀⠀⠀⢠⣿⠁⠀⠀⠀⠘⠿⠃⠀⢸⣿⣿⣿⣿
⠀⣠⡿⠛⢷⣦⡀⠀⠀⠈⣿⡄⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⠟
⢰⡿⠁⠀⠀⠙⢿⣦⣤⣤⣼⣿⣄⠀⠀⠀⠀⠀⢴⡟⠛⠋⠁⠀
⣿⠇⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠈⣿⡀⠀⠀⠀
⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡇⠀⠀⠀
⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⡇⠀⠀⠀
⠸⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡿⠀⠀⠀⠀
⠀⠹⣷⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣰⡿⠁⠀⠀⠀⠀
⠀⠀⠀⠉⠙⠛⠿⠶⣶⣶⣶⣶⣶⠶⠿⠟⠛⠉⠀⠀⠀⠀⠀⠀
 ]]
			}
		},
		animate = { enabled = true },
		indent = {
			enabled = true,
			animate = {
				enabled = false,
				style = "out",
				easing = "linear",
				duration = {
					step = 10,
					total = 250
				}
			}
		},
		picker = {
			actions = {
				smart_open = function(picker, item)
					if not item.dir then
						local ok = picker:action({ "pick_win", "jump" })
						if ok then return end
					end
					picker:action({ "confirm" })
				end
			},
			win = {
				input = {
					keys = {
						["<CR>"] = {
							{
								"smart_open"
							},
							mode = { "n", "i" }
						},
					},
				},
				list = {
					keys = {
						["<CR>"] = { "smart_open" }
					},
				},
			},
			enabled = true,
			sources = {
				explorer = {
					auto_close = true,
					win = {
						list = {
							keys = {
								["a"] = "explorer_add",
								["d"] = "explorer_del",
								["r"] = "explorer_rename",
								["c"] = "explorer_copy",
								["p"] = "explorer_paste",
								["u"] = "explorer_update",
								["x"] = "explorer_move",
								["y"] = "explorer_yank",
								["<CR>"] = "smart_open"
							}
						}
					}
				},
			},
		},
		bigfile = { enabled = true },
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		zen = {
			enabled = true,
			center = true,
			toggles = { dim = true }
		},
	},
}
