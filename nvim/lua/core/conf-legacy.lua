-- /// CONF-LEGACY.LUA | vimscript commands ///

vim.cmd [[
  set noshowmode " hiding mode indicators
  set splitbelow " Splits will go below
  set splitright " Splits will go to the right
  set noswapfile " Doesn't generate swap file
  " remaps
  nnoremap <silent> <C-l> :set nu!<CR>
  nnoremap <silent> <C-Up> :m-2<CR>
  nnoremap <silent> <C-Down> :m+1<CR>
]]

-- vim: ts=2 sts=2 sw=2 et
