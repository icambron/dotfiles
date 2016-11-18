" Facts
let os = substitute(system('uname'), "\n", "", "")
filetype on

" Basics
set timeoutlen=1000 ttimeoutlen=0 " Get rid of delays
set nocompatible
set encoding=utf-8
set noswapfile
set history=1000
set backup
set backupdir=~/.vim/back
set exrc            " enable per-directory .vimrc files
set secure          " disable unsafe commands in local .vimrc files

if has('persistent_undo')
  set undofile
  set undolevels=1000
  set undoreload=10000
  set undodir=~/.vim/undo
endif

" UI
set background=dark
set number
set ruler
set shortmess+=filmnrxoOtT      " Abbrev. of messages (avoids 'hit enter')
set cursorline
set showmatch

set list                        " Show invisible characters
set listchars=""                " Reset the listchars
set listchars=tab:\ \           " A tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.          " show trailing spaces as dots
set listchars+=extends:>        " The character to show in the last column when wrap is off and the line continues beyond the right of the screen
set listchars+=precedes:<       " The character to show in the last column when wrap is

set laststatus=2                " Not sure what this does, but it unconfuses airline

set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*
set wildignore+=*.swp,*~,._*
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

" GUI customization
set guicursor=a:blinkon0        " Shut off the fucking blinking cursor
set guioptions-=T               " Remove toolbar
set guioptions-=L
set guioptions=-l

if os == "Darwin"
  set guifont=Inconsolata\ for\ Powerline:h13
endif
if has("gui_running")
  if has("autocmd")
    autocmd VimResized * wincmd = " Automatically resize splits when resizing MacVim window
  endif
endif

" Search
set hlsearch          " Highlight matches
set incsearch         " Incremental searching
set ignorecase        " Searches are case insensitive...
set smartcase         " ...Unless they contain at least one capital letter

" Editing/Formatting
set backspace=indent,eol,start  " Backspace for dummies
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
set pastetoggle=<F4>

" Text wrapping
set nowrap
set textwidth=0
set wrapmargin=0

" Clipboard
if os == "Linux"
  set clipboard=unnamedplus
elseif os == "Darwin"
  set clipboard=unnamed
endif

" Config settings for plugins
let g:fakeclip_provide_clipboard_key_mappings = 1
let g:fakeclip_terminal_multiplexer_type = "tmux"
let g:airline_theme = 'murmur'
let g:airline#extensions#tagbar#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_detect_whitespace = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']

if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
endif

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=white ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=gray ctermbg=237

" Vundle incantation
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Plugin 'tpope/vim-repeat'
Plugin 'kana/vim-fakeclip'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'szw/vim-maximizer'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'rgarver/Kwbd.vim'

if executable('ctags')
  Plugin 'majutsushi/tagbar'
endif

Plugin 'cakebaker/scss-syntax.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'slim-template/vim-slim'
Plugin 'elzr/vim-json'
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'tpope/vim-markdown'
Plugin 'chrisbra/csv.vim'
Plugin 'guns/vim-clojure-static'
Plugin 'derekwyatt/vim-scala'
Plugin 'itchyny/landscape.vim'
Plugin 'amdt/vim-niji'

call vundle#end()

syntax enable                   " Turn on syntax highlighting allowing local overrides
filetype plugin indent on

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"unclear why these are needed - shouldn't the plugins handle this automatically?
autocmd BufRead,BufNewFile {*.coffee,Cakefile} setf coffee
autocmd BufRead,BufNewFile {*.litcoffee} setf litcoffee
autocmd BufRead,BufNewFile {Vagrantfile} setf ruby
autocmd BufRead,BufNewFile {Dockerfile} setf dockerfile
autocmd BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown
autocmd BufRead,BufNewFile {*.slim} setf slim
autocmd BufRead,BufNewFile {*.scala} setf scala
autocmd BufRead,BufNewFile {*.cljs} setf clojure
autocmd BufNewFile,BufRead *.md set filetype=markdown

" Colors
colorscheme landscape
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
" not sure why i need this...
hi Cursor guibg=black guifg=gray

" Keybindings
let mapleader = "\<Space>"
nmap <leader>sp :Ack<SPACE>
nmap <leader>pI :CtrlPClearAllCaches<CR>
nmap <silent> <leader>pf :CtrlP<CR>
nmap <silent> <leader>pr :CtrlPMRU<CR>
nmap <silent> <leader>bb :CtrlPBuffer<CR>
nmap <silent> <Leader>sc :noh<CR>
nmap <silent> <leader>bd<CR> :<C-u>Kwbd<CR>
nmap <silent> <Leader>ti <Plug>IndentGuidesToggle
nmap <LEADER>w- :sp<CR>
nmap <LEADER>w/ :vsp<CR>
nmap <LEADER>w= <C-W>=
nmap <LEADER>wh <C-W>h
nmap <LEADER>wj <C-W>j
nmap <LEADER>wk <C-W>k
nmap <LEADER>wl <C-W>l
nmap <LEADER>ws <C-W>s
nmap <LEADER>wv <C-W>v
nmap <LEADER>wm :MaximizerToggle<CR>
nmap <LEADER>ww <C-W><C-W>
nmap <LEADER>feR :source ~/.vimrc<CR>
