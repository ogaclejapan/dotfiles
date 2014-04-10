
" :NeoBundleInstall
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" Install Bundle
NeoBundle 'Shougo/unite.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'altercation/vim-colors-solarized'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

" Builtin Settings
set number
set backspace=indent,eol,start
set history=1000
set showcmd
set showmode
set visualbell
set autoread                 

set hidden

syntax on

let mapleader="," 

set noswapfile
set nobackup
set nowb

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

set clipboard=unnamed
set encoding=utf-8 nobomb
set backspace=indent,eol,start

set list listchars=tab:\ \ ,trail:·

set nowrap
set linebreak

" Bundle Settings
"let g:lightline = { 'colorscheme' : 'solarized' }

