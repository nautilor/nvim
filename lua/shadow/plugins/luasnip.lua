return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	config = function()
		local ls = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets/" })
	end,
}
