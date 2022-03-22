" where N is NOT the buffer number but the INDEX in such list
" NOTE: it does not include terminal buffers
nnoremap <Leader>1 :lua require("nvim-smartbufs").goto_buffer(1)<CR>
nnoremap <Leader>2 :lua require("nvim-smartbufs").goto_buffer(2)<CR>
nnoremap <Leader>3 :lua require("nvim-smartbufs").goto_buffer(3)<CR>
nnoremap <Leader>4 :lua require("nvim-smartbufs").goto_buffer(4)<CR>
nnoremap <Leader>5 :lua require("nvim-smartbufs").goto_buffer(5)<CR>
nnoremap <Leader>6 :lua require("nvim-smartbufs").goto_buffer(6)<CR>
nnoremap <Leader>7 :lua require("nvim-smartbufs").goto_buffer(7)<CR>
nnoremap <Leader>8 :lua require("nvim-smartbufs").goto_buffer(8)<CR>
nnoremap <Leader>9 :lua require("nvim-smartbufs").goto_buffer(9)<CR>

" Delete current buffer and goes back to the previous one
nnoremap <Leader>qq :lua require("nvim-smartbufs").close_current_buffer()<CR>

" Delete the N buffer according to :ls buffer list
nnoremap <Leader>q1 :lua require("nvim-smartbufs").close_buffer(1)<CR>
nnoremap <Leader>q2 :lua require("nvim-smartbufs").close_buffer(2)<CR>
nnoremap <Leader>q3 :lua require("nvim-smartbufs").close_buffer(3)<CR>
nnoremap <Leader>q4 :lua require("nvim-smartbufs").close_buffer(4)<CR>
nnoremap <Leader>q5 :lua require("nvim-smartbufs").close_buffer(5)<CR>
nnoremap <Leader>q6 :lua require("nvim-smartbufs").close_buffer(6)<CR>
nnoremap <Leader>q7 :lua require("nvim-smartbufs").close_buffer(7)<CR>
nnoremap <Leader>q8 :lua require("nvim-smartbufs").close_buffer(8)<CR>
nnoremap <Leader>q9 :lua require("nvim-smartbufs").close_buffer(9)<CR>
