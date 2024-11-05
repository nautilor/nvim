return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = { "java", "python", "c", "lua", "vim", "vimdoc", "javascript", "typescript", "dockerfile", "bash", "markdown", "tsx" },
		sync_install = true,
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = { enable = true },
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end
}
