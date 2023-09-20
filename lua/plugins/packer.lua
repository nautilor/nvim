-- insert all the plugind you need here
return require('packer').startup(function(use)

	-- packer will manage hitself like this
	use 'wbthomason/packer.nvim'

	-- lualine works with nvim-web-devicons
	use 'nvim-lualine/lualine.nvim'
	requires = { 'nvim-tree/nvim-web-devicons', opt = true }

end)
