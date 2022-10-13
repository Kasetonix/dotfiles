" ██╗   ██╗██╗███╗   ███╗
" ██║   ██║██║████╗ ████║
" ██║   ██║██║██╔████╔██║
" ╚██╗ ██╔╝██║██║╚██╔╝██║
"  ╚████╔╝ ██║██║ ╚═╝ ██║
"   ╚═══╝  ╚═╝╚═╝     ╚═╝

" Editor settings
set number " Setting line numbers
"set relativenumber " setting relative line numbers
set tabstop=4 " Setting tab length
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
filetype plugin indent on
set wildmode=longest,list

" Theming
set background=dark " Setting dark background
hi Normal guibg=NONE ctermbg=NONE " Enabling transparency

" Keybindings
nnoremap <C-a> :q<CR> " Exiting
nnoremap <C-q> :wq<CR> 
nnoremap <C-s> :vsplit 
nnoremap <C-t> :tabnew 
nnoremap <C-n> :tabprevious<CR> 
nnoremap <C-m> :tabnext<CR>
nnoremap <C-l> :set nu!<CR> :set norelativenumber<CR>
