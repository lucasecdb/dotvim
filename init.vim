set langmenu=en_US
let $LANG='en_US'

filetype indent plugin on

packadd minpac

call minpac#init({ 'verbose': 3 })

" Packages
call minpac#add('myusuf3/numbers.vim')
call minpac#add('tpope/vim-surround')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('mxw/vim-jsx')
call minpac#add('tpope/vim-fugitive')
call minpac#add('jiangmiao/auto-pairs')
call minpac#add('isRuslan/vim-es6')
call minpac#add('flowtype/vim-flow')
call minpac#add('leafgarland/typescript-vim')
call minpac#add('w0rp/ale')

set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2

set number
set backspace=indent,eol,start
syntax on

" command aliases
command Nt NERDTree
command W w
command Q q

" color scheme
if has('gui')
  set linespace=3
endif

set termguicolors
set background=dark
colorscheme codedark

" key mappings
nnoremap <c-h> :tabn<cr>
nnoremap <c-l> :tabp<cr>

nnoremap <s-h> :bnext<cr>
nnoremap <s-l> :bprevious<cr>

if has('gui')
  set guioptions-=r
  set guioptions-=L
endif

let g:flow#enable = 0

" airline setup
let g:airline_powerline_fonts = 1
let g:airline_theme='lucius'
let g:airline_left_sep=''
let g:airline_right_sep=''
set laststatus=2

set guifont=Operator\ Mono\ Medium\ 11

" use system clipboard by default
" (obs.: must compile vim from source)
set clipboard=unnamedplus

" keep at least 3 lines bellow the cursor
set scrolloff=3
