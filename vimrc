filetype indent plugin on

set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

set number
set backspace=indent,eol,start
set noesckeys
syntax on

" command aliases
command Nt NERDTree
command W w
command Q q

" color scheme
colorscheme predawn
"set background=dark

" key mappings
inoremap <c-u> <esc>viwUi
nnoremap <c-u> viwU
nnoremap <c-n> :Nt<cr><c-w><c-w>

" misc
" set term=xterm-256color
set nocompatible

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

" airline setup
let g:airline_powerline_fonts = 1
" let g:airline_theme='kolor'
set guifont=Source\ Code\ Pro\ for\ Powerline\ 10
set laststatus=2

" numbers.vim settings
let g:numbers_exclude = ['nerdtree']

" use system clipboard by default
set clipboard=unnamedplus

" keep at least 3 lines bellow the cursor
set scrolloff=3
