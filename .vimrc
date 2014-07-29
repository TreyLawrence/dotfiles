set shell=/bin/bash
set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/vundle'

" required!
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-abolish'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'wting/rust.vim'
Plugin 'dag/vim2hs'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Raimondi/YAIFA'
call vundle#end() 
filetype plugin indent on    " required!

set rtp+=$GOROOT/misc/vim

syntax enable
colorscheme solarized

let g:SuperTabDefaultCompletionType = "context"
let g:syntastic_always_populate_loc_list=1

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

set number
set relativenumber
set colorcolumn=80

set incsearch
set smartcase
set ignorecase

set listchars=tab:·\ ,trail:·

let mapleader=" "
nnoremap <Leader>q :q<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>e :e
nnoremap <Leader>p :CtrlP<CR>
nnoremap <Leader>o :CtrlPBuffer<CR>
nnoremap <Leader>n :ll<CR>
nnoremap <Leader>m :lnext<CR>

" Vim!
nnoremap <Leader>gg :Ggrep -i ""<left>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>= <C-w><C-=>

nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

autocmd QuickFixCmdPost *grep* cwindow

" Syntastic Stuff
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute "]
let g:pyflakes_use_quickfix = 0

" YAIFA Stuff
let g:yaifa_tab_width=4
let g:yaifa_indentation=0
autocmd BufReadPost * :silent !YAIFAMagic

" Go Stuff
au FileType go nmap <Leader>i <Plug>(go-import)
au FileType go nmap <Leader>d <Plug>(go-def)
au FileType go nmap <Leader>sd <Plug>(go-def-split)
au FileType go nmap <Leader>vd <Plug>(go-def-vertical)

nnoremap <Leader>qj ^yw$a `json:"phcrsA"`j

" Ctrl-P
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](.git|.arc|dist|components|node_modules|ios)$',
  \ }
