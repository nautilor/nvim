-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Telescope FZF
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Everforest colorscheme
  use({
	  "neanias/everforest-nvim",
	  -- Optional; default configuration will be used if setup isn't called.
	  config = function()
		  require("everforest").setup()
	  end,
  })

  -- Make color and syntax highlight better
  use('nvim-treesitter/nvim-treesitter', {run = 'TSUpdate'})

  -- Statusbar and bufferline all in one place
  use('ojroques/nvim-hardline')

  -- Add a terminal like in vscode
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
	  require("toggleterm").setup()
  end}

  use("lewis6991/gitsigns.nvim")

end)
