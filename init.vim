" BASE CONFIG
source C:/users/ryans/appdata/local/nvim/vimscript/config.vim


" LOAD PLUGINS USING PACKER
lua require('plugins')
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end


" TELESCOPE
source C:/users/ryans/appdata/local/nvim/vimscript/telescope_config.vim


" FILE TREE
source C:/users/ryans/appdata/local/nvim/vimscript/file_tree_config.vim


" DASHBOARD
source C:/users/ryans/appdata/local/nvim/vimscript/dashboard_config.vim


" WILDER
source C:/users/ryans/appdata/local/nvim/vimscript/wilder_config.vim


" VISTA
source C:/users/ryans/appdata/local/nvim/vimscript/vista_config.vim


" BUFFER
source C:/users/ryans/appdata/local/nvim/vimscript/buffer_config.vim
