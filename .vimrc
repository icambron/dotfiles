" Minimal vimrc for random situations where I can't/don't want to use neovim

filetype on
syntax enable
set secure
set timeoutlen=1000 ttimeoutlen=0
set nocompatible
set encoding=utf-8
set noswapfile
set history=1000
set noerrorbells visualbell t_vb=set noerrorbells visualbell t_vb= " shut the fuck up, Donny

set background=dark
set shortmess+=filmnrxoOtT
set nocursorline
set showmatch

set hlsearch
set incsearch
set ignorecase
set smartcase

set backspace=indent,eol,start
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
set nowrap
set textwidth=0
set wrapmargin=0

hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
