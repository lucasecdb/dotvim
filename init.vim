filetype indent plugin on

set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2

set number
set backspace=indent,eol,start
set noesckeys
syntax on

" command aliases
command Nt NERDTree
command W w
command Q q

" color scheme
if has('gui')
  set linespace=3
endif

set background=dark
colorscheme neodark

" key mappings
inoremap <c-u> <esc>viwUi
nnoremap <c-u> viwU
nnoremap <c-n> :Nt<cr><c-w><c-w>

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

nnoremap <s-h> :bnext<cr>
nnoremap <s-l> :bprevious<cr>

" misc
set nocompatible

if has('gui')
  set guioptions-=r
  set guioptions-=L
endif

" pathogen
execute pathogen#infect()

" syntastic setup
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_java_checkers = ['javac']
let g:syntastic_cpp_compiler_options = ' -std=c++11'

let g:flow#enable = 0

" airline setup
let g:airline_powerline_fonts = 1
let g:airline_theme='lucius'
let g:airline_left_sep=''
let g:airline_right_sep=''
set laststatus=2

set guifont=Operator\ Mono\ Medium\ 11

" numbers.vim settings
let g:numbers_exclude = ['nerdtree']

" use system clipboard by default
" (obs.: must compile vim from source)
set clipboard=unnamedplus

" keep at least 3 lines bellow the cursor
set scrolloff=3
