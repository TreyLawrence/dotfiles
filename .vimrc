set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'kien/ctrlp.vim'
Plugin 'fholgado/minibufexpl.vim'
call vundle#end()            " required
filetype plugin indent on    " required
set rtp+=~/go/src/github.com/golang/lint/misc/vim

colorscheme solarized
:set number


set rtp+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

autocmd BufWritePre *.go Fmt

set expandtab
set shiftwidth=2
set softtabstop=2
set mouse=a

set clipboard=unnamed
