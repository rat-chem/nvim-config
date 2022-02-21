set nocompatible
set number
set signcolumn=yes
syntax enable
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set title
set autoindent
set background=dark
set nobackup
set hlsearch
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=10
set expandtab
set omnifunc=syntaxcomplete#Complete
set hidden
set noerrorbells
set relativenumber
set nohlsearch
set nuw=4
set nowrap

let mapleader = " "
set termguicolors

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'davidcelis/vim-ariake-dark'
Plug 'ghifarit53/tokyonight-vim'
" Plug 'arcticicestudio/nord-vim'
" Plug 'shaunsingh/nord.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'windwp/nvim-autopairs'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mhinz/vim-signify'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'glepnir/dashboard-nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'andweeb/presence.nvim'
Plug 'davidhalter/jedi-vim'
Plug 'deoplete-plugins/deoplete-jedi'

" Initialize plugin system
call plug#end()

let g:dashboard_disable_at_vimenter = 0
let g:dashboard_disable_statusline = 1
let g:dashboard_default_executive = "telescope"
let g:dashboard_custom_header =[
    \'                                   ',
    \'                                   ',
    \'                                   ',
    \'                                   ',
    \'                                   ',
    \'          ▀████▀▄▄              ▄█ ',
    \'            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ',
    \'    ▄        █          ▀▀▀▀▄  ▄▀  ',
    \'   ▄▀ ▀▄      ▀▄              ▀▄▀  ',
    \'  ▄▀    █     █▀   ▄█▀▄      ▄█    ',
    \'  ▀▄     ▀▄  █     ▀██▀     ██▄█   ',
    \'   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ',
    \'    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ',
    \'   █   █  █      ▄▄           ▄▀   ',
    \'                                   ',
    \'                                   ',
    \]

lua << EOF
  local custom_lsp_attach = function(client)
    -- See `:help nvim_buf_set_keymap()` for more information
    vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
    vim.api.nvim_buf_set_keymap(0, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
    -- ... and other keymappings for LSP

    -- Use LSP as the handler for omnifunc.
    --    See `:help omnifunc` and `:help ins-completion` for more information.
    vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Use LSP as the handler for formatexpr.
    --    See `:help formatexpr` for more information.
    vim.api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

    -- For plugins with an `on_attach` callback, call them here. For example:
    -- require('completion').on_attach()

    local diagnostic_opts = {
      underline = true,
      virtual_text = false, -- this it what you're looking for
      signs = false,
      update_in_insert = true,
    }

    lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, diagnostic_opts)
  end

  -- An example of configuring for `sumneko_lua`,
  --  a language server for Lua.

  -- set the path to the sumneko installation
  local system_name = "Windows" -- (Linux, macOS, or Windows)
  local sumneko_root_path = '/path/to/lua-language-server'
  local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

  require'lspconfig'.tsserver.setup{}
  -- require'lspconfig'.pylsp.setup{}
  -- require'lspconfig'.pyright.setup{}
  require'lspconfig'.jedi_language_server.setup{}

  require('telescope').setup{
    defaults = {
      -- Default configuration for telescope goes here:
      -- config_key = value,
      
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
         horizontal = {
            prompt_position = "bottom",
            preview_width = 0.55,
            results_width = 0.8,
         },
         vertical = {
            mirror = false,
         },
         width = 0.87,
         height = 0.80,
         preview_cutoff = 120,
      },

      path_display = { "truncate" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,

      file_sorter = require('telescope.sorters').get_fzy_sorter,
      prompt_prefix = ' > ',
      color_devicons = true,

      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      file_ignore_patterns = { "node_modules", ".next", ".git" },

      mappings = {
        i = {
          -- map actions.which_key to <C-h> (default: <C-/>)
          -- actions.which_key shows the mappings for your picker,
          -- e.g. git_{create, delete, ...}_branch for the git_branches picker

        }
      }
    },
    pickers = {
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      }
    }
  }

  require('telescope').load_extension('fzy_native')

  require("indent_blankline").setup {
    indentLine_enabled = 1,
    char = "▏",
    filetype_exclude = {
        "help",
        "terminal",
        "dashboard",
        "packer",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "nvchad_cheatsheet",
        "lsp-installer",
        "",
    },
    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
  }
EOF

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fd <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

set updatetime=100

" colorscheme Ariake-Dark
let g:tokyonight_style = 'storm'
colorscheme tokyonight
" colorscheme nord
" let g:nord_contrast = v:true
" let g:nord_borders = v:true
" let g:nord_disable_background = v:true
" let g:nord_italic = v:true

" autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
" For Vim<8, replace EndOfBuffer by NonText
" autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE
" hi LineNr ctermfg=2 guifg='#7AA2F7' guibg='#24283b'
hi SignColumn guibg=NONE ctermbg=NONE
" hi LineNr guifg=#7AA2F7
" highlight SignifySignAdd guifg=NONE
" highlight SignifySignDelete guifg=NONE
" highlight SignifySignChange guifg=NONE
hi GitGutterAdd guifg=#9ECE6A guibg=NONE
hi GitGutterChangeDelete guifg=#ad8ee6 guibg=NONE
hi GitGutterChange guifg=#7AA2F7 guibg=NONE
hi GitGutterDelete guifg=#F7768E guibg=NONE
hi ALEErrorSign guifg=#F7768E guibg=NONE
hi ALEWarningSign guifg=#E0AF68 guibg=NONE
hi ALEInfoSign guifg=#a9b1d6 guibg=NONE
hi ALEHintSign guifg=#a9b1d6 guibg=NONE
hi DiagnosticError guifg=#F7768E guibg=NONE
hi DiagnosticWarn guifg=#a9b1d6 guibg=NONE
hi DiagnosticInfo guifg=#a9b1d6 guibg=NONE
hi DiagnosticHint guifg=#a9b1d6 guibg=NONE
" hi Comment guifg=#9eaeff
" hi SpecialKey guifg=#9eaeff
" hi NonText guifg=#ad8ee6

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1
let g:airline_section_c = ''
let g:airline_section_error = ''
let g:airline_section_warning = ''

let g:jedi#completions_enbale = 0
let g:jedi#popup_on_dot = 0
