-- /// CONF-LEGACY.LUA | vimscript commands ///

vim.cmd [[
  set noshowmode " hiding mode indicators
  set splitbelow " Splits will go below
  set splitright " Splits will go to the right
  set noswapfile " Doesn't generate swap file
  " remaps
  "nnoremap <C-a> :q<CR> " Exiting
  "nnoremap <C-q> :wq<CR>
  nnoremap <C-s> :vsplit 
  nnoremap <C-t> :tabnew 
  nnoremap <C-l> :set nu!<CR> :set norelativenumber<CR>
]]

-- vim: ts=2 sts=2 sw=2 et
