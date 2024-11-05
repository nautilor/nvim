return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	 lazy = false,
	opts = {
		ensure_installed = { "java", "python", "c", "lua", "vim", "vimdoc", "javascript", "typescript" },
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = { enable = true },
	}
}
