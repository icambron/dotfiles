" Facts
let os = substitute(system('uname'), "\n", "", "")

" Vundle incantation
filetype on
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Functions
function! s:setupWrapping()
  set wrap
  set linebreak
  set textwidth=72
  set nolist
endfunction

" Basics
set timeoutlen=1000 ttimeoutlen=0 " Get rid of delays
set nocompatible      " Use vim, no vi defaults
set encoding=utf-8    " Set default encoding to UTF-8
set noswapfile
set history=1000
set backup                  " Backups are nice ...
set backupdir=~/.vim/back
if has('persistent_undo')
  set undofile              " So is persistent undo ...
  set undolevels=1000       " Maximum number of changes that can be undone
  set undoreload=10000      " Maximum number lines to save for undo on a buffer reload
  set undodir=~/.vim/undo
endif

" UI
set background=dark
set number                      " Show line numbers
set ruler                       " Show line and column number
set shortmess+=filmnrxoOtT      " Abbrev. of messages (avoids 'hit enter')
"set cursorline
set showmatch

set list                          " Show invisible characters
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the screen

" GUI customization
set guicursor=a:blinkon0 " Shut off the fucking blinking cursor
set guioptions-=T  "remove toolbar
set guioptions-=L
set guioptions=-l

if os == "Darwin"
  set guifont=Inconsolata\ for\ Powerline:h13
endif
if has("gui_running")
  if has("autocmd")
    " Automatically resize splits when resizing MacVim window
    autocmd VimResized * wincmd =
  endif
endif

" Search
set hlsearch          " highlight matches
set incsearch         " incremental searching
set ignorecase        " searches are case insensitive...
set smartcase         " ... unless they contain at least one capital letter

" Editing/Formatting
set backspace=indent,eol,start           " Backspace for dummies
nnoremap <leader>fef :normal! gg=G``<CR> " Format the entire file
nmap <leader>u mQviwU`Q                  " upper/lower word
nmap <leader>l mQviwu`Q
nmap <leader>U mQgewvU`Q                 " upper/lower first char of word
nmap <leader>L mQgewvu`Q
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`' " swap two words
if exists("g:enable_mvim_shift_arrow")
  let macvim_hig_shift_movement = 1 " mvim shift-arrow-keys
endif

if has("gui_macvim") && has("gui_running")
  vmap <D-]> >gv                    " Map command-[ and command-] to indenting or outdenting while keeping the original selection in visual mode 
  vmap <D-[> <gv

  nmap <D-]> >>
  nmap <D-[> <<

  omap <D-]> >>
  omap <D-[> <<

  imap <D-]> <Esc>>>i
  imap <D-[> <Esc><<i

  nmap <D-Up> [e                    " Bubble single lines
  nmap <D-Down> ]e
  nmap <D-k> [e
  nmap <D-j> ]e

  vmap <D-Up> [egv                  " Bubble multiple lines 
  vmap <D-Down> ]egv
  vmap <D-k> [egv
  vmap <D-j> ]egv

else

  vmap <A-]> >gv                    " Map command-[ and command-] to indenting or outdenting while keeping the original selection in visual mode
  vmap <A-[> <gv

  nmap <A-]> >>
  nmap <A-[> <<

  omap <A-]> >>
  omap <A-[> <<

  imap <A-]> <Esc>>>i
  imap <A-[> <Esc><<i

  nmap <C-Up> [e                    " Bubble single lines
  nmap <C-Down> ]e
  nmap <C-k> [e
  nmap <C-j> ]e

  vmap <C-Up> [egv                  " Bubble multiple lines 
  vmap <C-Down> ]egv
  vmap <C-k> [egv
  vmap <C-j> ]egv
endif

Bundle 'Lokaltog/vim-easymotion'
Bundle 'mbbill/undotree'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'matchit.zip'

" tmux
Bundle 'christoomey/vim-tmux-navigator'
let g:fakeclip_provide_clipboard_key_mappings = 1
let g:fakeclip_terminal_multiplexer_type = "tmux"
Bundle 'kana/vim-fakeclip'

" Tabbing
Bundle 'nathanaelkane/vim-indent-guides'
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
set pastetoggle=<F4>

" Text wrapping
set nowrap
set textwidth=0
set wrapmargin=0

" Buffer/file management
nmap <silent> <leader>cd :lcd %:h<CR>         " cd to the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR> " Create the directory containing the file in the buffer
Bundle 'vim-scripts/ZoomWin'

Bundle 'rgarver/Kwbd.vim'
nnoremap <silent> ,d :<C-u>Kwbd<CR>

set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*
set wildignore+=*.swp,*~,._*
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

" Clipboard
if os == "Linux"
  set clipboard=unnamedplus
elseif os == "Darwin"
  set clipboard=unnamed
endif

" Status bar
set laststatus=2                       " not sure what this does, but it unconfuses airline
Bundle 'bling/vim-airline'
let g:airline_theme = 'powerlineish'
let g:airline#extensions#tagbar#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_detect_whitespace = 0

" Git
Bundle 'tpope/vim-fugitive'
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>:GitGutter<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>:GitGutter<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <silent> <leader>gg :GitGutterToggle<CR>
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Code
Bundle 'scrooloose/syntastic'
if executable('ctags')
  Bundle 'majutsushi/tagbar'
endif

" Finding files
Bundle 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']

" Ack stuff
if executable('ag')
  Bundle 'mileszs/ack.vim'
  let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
elseif executable('ack-grep')
  let g:ackprg="ack-grep -H --nocolor --nogroup --column"
  Bundle 'mileszs/ack.vim'
elseif executable('ack')
  Bundle 'mileszs/ack.vim'
endif

" Languages
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rvm'
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

Bundle 'cakebaker/scss-syntax.vim'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'groenewege/vim-less'

Bundle 'amirh/HTML-AutoCloseTag'
Bundle 'tpope/vim-haml'
Bundle 'slim-template/vim-slim'
autocmd BufRead,BufNewFile {*.slim} setf slim

Bundle 'elzr/vim-json'
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
autocmd BufRead,BufNewFile {*.coffee,Cakefile} setf coffee
Bundle "jQuery"

Bundle 'tpope/vim-markdown'
autocmd BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown

Bundle 'chrisbra/csv.vim'

Bundle 'guns/vim-clojure-static'
Bundle 'tpope/vim-leiningen'
Bundle 'tpope/vim-projectionist'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-fireplace'
Bundle 'luochen1990/rainbow'
let g:rainbow_active = 0

syntax enable                   " Turn on syntax highlighting allowing local overrides

" End Vundle encantation
filetype plugin indent on

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Colors
Bundle 'rking/vim-detailed'
colorscheme detailed

"Use tomorrow night everywhere, but switch to vim-detailed for ruby
Bundle 'chriskempson/vim-tomorrow-theme'
"colorscheme Tomorrow-Night-Bright
"autocmd BufEnter,BufNewFile {*.rb,Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} colorscheme detailed
"autocmd BufLeave {*.rb,Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} colorscheme Tomorrow-Night-Bright

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif
