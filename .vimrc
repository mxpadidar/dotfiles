call plug#begin('~/.vim/plugged')
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }
call plug#end()


syntax on
colorscheme catppuccin_mocha
let g:lightline = {'colorscheme': 'catppuccin_mocha'}


" General options
set termguicolors
set number
set relativenumber
set cursorline
set encoding=utf-8
set background=dark
set signcolumn=yes
set laststatus=2
set clipboard=unnamedplus
set scrolloff=8
let g:netrw_banner = 0  " hide the banner of file explorer

" Indentation settings
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set smartindent

" List characters
" set list
" set listchars=tab:→\ ,space:·,trail:·,extends:»,precedes:«,nbsp:␣

" Disable bclose multiple buffers
let g:bclose_multiple = 0

