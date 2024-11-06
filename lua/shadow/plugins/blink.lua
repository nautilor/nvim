return {
	"saghen/blink.cmp",
	dependencies = { 'rafamadriz/friendly-snippets' },
	event = { "LspAttach" },
	version = 'v0.*',
	opts = {
		keymap = { preset = 'super-tab' },
		highlight = {
			use_nvim_cmp_as_default = true
		}
	}
}
