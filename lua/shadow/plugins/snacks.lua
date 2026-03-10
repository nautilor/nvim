local function choose_picker_action(source)
	local Snacks = require("snacks")
	local explorer = Snacks.picker.get({ source = source })
	if #explorer == 0 then return end
	local node = explorer[1]
	local cursor = node.list.cursor
	local item = node.finder.items[cursor]
	if item == nil then return end
	if item.type ~= "directory" then
		local ok = node:action({ "pick_win", "jump" })
		if ok then return end
	end
	node:action({ "confirm" })
end

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
								["<CR>"] = function()
									choose_picker_action("explorer")
								end
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
