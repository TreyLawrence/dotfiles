set shell=/bin/bash
set nocompatible              " be iMproved
filetype off                  " required!
set write

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Raimondi/YAIFA'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'd11wtq/ctrlp_bdelete.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'python-mode/python-mode'
call vundle#end() 
filetype plugin indent on    " required!

set rtp+=$GOROOT/misc/vim

syntax on
colorscheme solarized
set background=dark

let g:SuperTabDefaultCompletionType = "context"
let g:syntastic_always_populate_loc_list=1

let g:jsx_ext_required = 0

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

set number
set colorcolumn=80

set incsearch
set smartcase
set ignorecase

set listchars=tab:·\ ,trail:·

let mapleader=" "
nnoremap <Leader>q :q<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>p :CtrlP<CR>
nnoremap <Leader>o :CtrlPBuffer<CR>
nnoremap <Leader>n :ll<CR>
nnoremap <Leader>m :lnext<CR>

" Vim!
nnoremap <leader>= <C-w><C-=>
nnoremap <leader>gb :Gblame<cr>

nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

autocmd QuickFixCmdPost *grep* cwindow

map <C-n> :NERDTreeToggle<CR>
nmap <C-t> :TagbarToggle<CR>

" Syntastic Stuff
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute "]
let g:pyflakes_use_quickfix = 0

" YAIFA Stuff
let g:yaifa_tab_width=4
let g:yaifa_indentation=0
autocmd BufReadPost * :silent !YAIFAMagic

" Go Stuff
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_snippet_engine = "neosnippet"
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <Leader>d <Plug>(go-def)
au FileType go nmap <Leader>hd <Plug>(go-def-split)
au FileType go nmap <Leader>vd <Plug>(go-def-vertical)

" Python Stuff
let g:pymode_options_max_line_length = 120
let python_highlight_all=1
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
set nofoldenable

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |

highlight BadWhitespace guibg=red ctermbg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

nnoremap <Leader>qj ^yw$a `json:"phcrsA"`j

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Ctrl-P
call ctrlp_bdelete#init()
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](pkg|.git)$',
  \ }
