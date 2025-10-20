return {
	"X3eRo0/dired.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = function(_, opts)
		local dired = require("dired")
		dired.setup(opts)
		vim.keymap.set("n", "<C-i>", function()
			-- Check if dired is running
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				local buf = vim.api.nvim_win_get_buf(win)
				local ft = vim.api.nvim_buf_get_option(buf, "filetype")
				if ft == "dired" then
					vim.cmd("DiredQuit")
					return
				end
			end

			-- Se non è aperto, apri uno split orizzontale con Dired
			vim.cmd("Dired")
		end, { desc = "Toggle Dired in horizontal split" })
	end
}
