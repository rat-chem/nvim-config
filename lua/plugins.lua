return require('packer').startup(function()
  -- PACKER CAN MANAGE ITSELF --
  use 'wbthomason/packer.nvim'


  -- ICON SUPPORT --
  use 'kyazdani42/nvim-web-devicons'


  -- GITSIGNS --
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }
  require('gitsigns').setup()


  -- WINDOW FOCUS SHADING --
  use 'sunjon/shade.nvim'
  require('shade_config')


  -- GIT INTEGRATION --
  use 'tpope/vim-fugitive'
  

  -- AUTO PAIRING --
  use 'windwp/nvim-autopairs'
  require('nvim-autopairs').setup {}


  -- HEX COLORIZATION --
  use 'norcalli/nvim-colorizer.lua'
  require('colorizer').setup()


  -- COMMENTING --
  use 'preservim/nerdcommenter'


  -- SCROLLBAR --
  use 'petertriho/nvim-scrollbar'
  require("scrollbar").setup {}


  -- LINE INDENTATION --
  use 'lukas-reineke/indent-blankline.nvim'
  require('indent_config')


  -- FUZZY FINDING --
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }
  require('telescope_config')


  -- NVIM NATIVE LSP --
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  require('lsp_config')


  -- SAME WORD HIGHLIGHT --
  use 'RRethy/vim-illuminate'


  -- AUTOCOMPLETION, ETC. --
  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }


  -- FILE TREE --
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
  }
  require('nvim-tree').setup()


  -- FILE STRUCTURE / TAGS --
  use 'liuchengxu/vista.vim'


  -- BETTER COMMAND LINE
  use 'gelguy/wilder.nvim'


  -- STARTUP DASHBOARD --
  use 'glepnir/dashboard-nvim'


  -- BUFFERLINE --
  use {
    'romgrk/barbar.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons'
    },
  }
  require('bufferline_config')
  use 'johann2357/nvim-smartbufs'


  -- SYNTAX HIGHLIGHTING --
  use 'nvim-treesitter/nvim-treesitter'
  require('treesitter_config')


  -- STATUSLINE --
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true
    },
  }
  require('lualine_config')


  -- COLORSCHEME --
  use "rebelot/kanagawa.nvim"
  use 'folke/tokyonight.nvim'
  use 'tiagovla/tokyodark.nvim'
  require('colorscheme')

  
  -- PATCHED NERD FONTS --
  use 'ryanoasis/vim-devicons'
end)
