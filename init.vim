set nocompatible
set number
set signcolumn=yes
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=UTF-8
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
set termguicolors
set tabstop=2
set shiftwidth=2
set expandtab

set guifont=SauceCodePro\ Nerd\ Font\ Mono

let mapleader = " "
syntax enable
filetype plugin on

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
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lualine/lualine.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'gelguy/wilder.nvim'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'liuchengxu/vista.vim'
Plug 'norcalli/nvim-colorizer.lua'
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

call wilder#setup({'modes': [':', '/', '?']})

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'nvim_lsp'
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1
let g:vista_sidebar_width = 40
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

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
    require'colorizer'.setup()

    local lualine = require('lualine')

    -- Color table for highlights
    -- stylua: ignore
    local colors = {
      bg       = '#202328',
      fg       = '#bbc2cf',
      yellow   = '#E0AF68',
      cyan     = '#008080',
      darkblue = '#081633',
      green    = '#9ECE6A',
      orange   = '#FF9E64',
      violet   = '#a9a1e1',
      magenta  = '#ad8ee6',
      blue     = '#7AA2F7',
      red      = '#F7768E',
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Config
    local config = {
      options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        theme = {
          -- We are going to use lualine_c an lualine_x as left and
          -- right section. Both are highlighted by c theme .  So we
          -- are just setting default looks o statusline
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x ot right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left {
      function()
        return '▊'
      end,
      color = { fg = colors.blue }, -- Sets highlighting of component
      padding = { left = 0, right = 1 }, -- We don't need space before this
    }

    ins_left {
      -- mode component
      function()
        return ''
      end,
      color = function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [''] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = colors.red,
          t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { right = 1 },
    }

    ins_left {
      -- filesize component
      'filesize',
      cond = conditions.buffer_not_empty,
    }

    ins_left {
      'filename',
      cond = conditions.buffer_not_empty,
      color = { fg = colors.magenta, gui = 'bold' },
    }

    ins_left { 'location' }

    ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

    ins_left {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = { error = ' ', warn = ' ', info = ' ' },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
      },
    }

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left {
      function()
        return '%='
      end,
    }

    ins_left {
      -- Lsp server name .
      function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = ' LSP:',
      color = { fg = '#ffffff', gui = 'bold' },
    }

    -- Add components to right sections
    ins_right {
      'o:encoding', -- option component same as &encoding in viml
      fmt = string.upper, -- I'm not sure why it's upper case either ;)
      cond = conditions.hide_in_width,
      color = { fg = colors.green, gui = 'bold' },
    }

    ins_right {
      'fileformat',
      fmt = string.upper,
      icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
      color = { fg = colors.green, gui = 'bold' },
    }

    ins_right {
      'branch',
      icon = '',
      color = { fg = colors.violet, gui = 'bold' },
    }

    ins_right {
      'diff',
      -- Is it me or the symbol for modified us really weird
      symbols = { added = ' ', modified = '柳 ', removed = ' ' },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    }

    ins_right {
      function()
        return '▊'
      end,
      color = { fg = colors.blue },
      padding = { left = 1 },
    }

    -- Now don't forget to initialize lualine
    lualine.setup(config)

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
let g:tokyonight_style = 'night'
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

"let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
"let g:airline#extensions#hunks#enabled=0
"let g:airline#extensions#branch#enabled=1
"let g:airline_section_c = ''
"let g:airline_section_error = ''
"let g:airline_section_warning = ''

let g:jedi#completions_enbale = 0
let g:jedi#popup_on_dot = 0
