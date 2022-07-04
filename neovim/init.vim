" Vim plug
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox' " Gruvbox theme
Plug 'altercation/vim-colors-solarized' "Solarized theme
Plug 'arcticicestudio/nord-vim' " Nord theme
Plug 'joshdick/onedark.vim' " One Dark theme
Plug 'vim-airline/vim-airline' " Vim airline
Plug 'vim-airline/vim-airline-themes' " Themes for vim airline
Plug 'chiel92/vim-autoformat' " Autoformatting
Plug 'ap/vim-css-color' " Color codes coloring in vim
Plug 'hdima/python-syntax' " Python syntax highligting
Plug 'octol/vim-cpp-enhanced-highlight' " C++ syntax highlighting
Plug 'vim-scripts/fish.vim' " Fish syntax highlighting
Plug 'tpope/vim-fugitive' " Plugin for git to make life easier
Plug 'scrooloose/nerdtree' " File explorer
Plug 'ryanoasis/vim-devicons' " Plugin for adding icons to VIM plugins
Plug 'Xuyuanp/nerdtree-git-plugin' " Plugin for showing Git statuses on NERDTree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Plugin for icons in NERDTree
call plug#end()

" Editor settings
set number " Setting line numbers
"set relativenumber " setting relative line numbers
set tabstop=4 " Setting tab length
set shiftwidth=4
"set expandtab " Changing tabs to spaces
"set softtabstop=4 " Deleting multiple spaces in the row
set encoding=utf-8 " Setting encoding
set wrap " Wrapping text if it goes beyond screen width
syntax on " Enabling syntax highlighting
set timeoutlen=0 ttimeoutlen=0 " changing delay times
"set mouse=a " Enabling mouse
set splitbelow " Splits will go below
set splitright " Splits will go to the right
set noswapfile " Doesn't generate swap file
"set cursorline " Highlits the line where the cursor is
filetype plugin indent on
set wildmode=longest,list

" Theming
colorscheme onedark " Setting theme
set background=dark " Setting dark background
hi Normal guibg=NONE ctermbg=NONE " Enabling transparency
set noshowmode " Removing bottom bar

" NERDTree settings
"autocmd VimEnter * NERDTree | wincmd p " Starting NERDTree at startup
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif " Exiting VIM if NERDTree is the only window left
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif " NERDTree is always in its window

" Keybindings
nnoremap <C-a> :q<CR> " Exiting
nnoremap <C-q> :wq<CR> 
nnoremap <C-f> :NERDTreeToggle<CR> " Toggling NERDTree with keybinding
nnoremap <C-s> :vsplit 
nnoremap <C-t> :tabnew 
"nnoremap <C-n> :tabprevious<CR> 
nnoremap <C-n> :tabnext<CR> 
"nnoremap <C-m> :tabnext<CR>
nnoremap <C-l> :set nu!<CR> :set norelativenumber<CR>
