-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Telescope FZF
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Telescope File browser
  use {
	  "nvim-telescope/telescope-file-browser.nvim",
	  requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }

  -- Everforest colorscheme
  use{
	  "neanias/everforest-nvim",
	  config = function()
		  require("everforest").setup()
	  end,
  }

  -- Neofusion colorscheme
  use {
	  "diegoulloao/neofusion.nvim",
	  config = function()
		  require("neofusion").setup()
	  end,
  }

	-- Catpuccin
	use { "catppuccin/nvim", as = "catppuccin" }

	-- Gruvbox
	use { "nautilor/gruvbox-darker.nvim" }

	-- Solarized
	use { "svrana/neosolarized.nvim",
				requires = { "tjdevries/colorbuddy.nvim" },
				config = function()
					require("neosolarized").setup({
						comment_italics = true,
						background_set = true
					})
				end,
			}

	use { 
				'navarasu/onedark.nvim',
				config = function()
					require('onedark').setup {
						style = 'darker'
					}
				end
			}

  -- Make color and syntax highlight better
  use('nvim-treesitter/nvim-treesitter', {run = 'TSUpdate'})

  -- statusline & bufferline
  use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- Add a terminal like in vscode
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
	  require("toggleterm").setup()
  end}

  -- Git blame in line
  use("lewis6991/gitsigns.nvim")

  -- Linter
  use('mfussenegger/nvim-lint')

  -- LSP in general
  use {
	  "williamboman/mason.nvim",
	  "williamboman/mason-lspconfig.nvim",
	  "neovim/nvim-lspconfig",
  }

  -- Autocomplete
  use {
	  "hrsh7th/nvim-cmp",
	  "hrsh7th/cmp-buffer",
	  "hrsh7th/cmp-path",
	  "hrsh7th/cmp-nvim-lsp",
  }

  -- Autopairs plugins for various characters
  use {
	  "windwp/nvim-autopairs",
	  event = "InsertEnter",
	  config = function()
		  require("nvim-autopairs").setup {}
	  end
  }

  -- Autotag to help with html/htmlx/etc... tags
  use { 
	  "windwp/nvim-ts-autotag",
	  config = function()
		  require("nvim-ts-autotag").setup {}
	  end
  }
	
  -- Formatter
  use{
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup()
    end,
  }

	use {
		"pmizio/typescript-tools.nvim",
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("typescript-tools").setup {}
		end,
	}

	-- Comment hightlight
	use {
		'nautilor/better-comments',
		config = function()
			require("better-comments").setup()
		end
	}

end)

