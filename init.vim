set langmenu=en_US
let $LANG='en_US'

filetype indent plugin on

""" Section: Packages {{{1

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
call minpac#add('pangloss/vim-javascript')
call minpac#add('w0rp/ale')
call minpac#add('lucasecdb/vim-codedark')
call minpac#add('scrooloose/nerdtree')

let g:flow#enable = 0

let g:airline_powerline_fonts = 1
let g:airline_theme='codedark'
let g:airline_left_sep=''
let g:airline_right_sep=''

set laststatus=2

""" }}}1
""" Section: Options {{{1

set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2

set number
set backspace=indent,eol,start
syntax on

if has('gui')
  set linespace=3
endif

set termguicolors
set background=dark
colorscheme codedark

set clipboard=unnamedplus
set scrolloff=3

if has('gui')
  set guioptions-=r
  set guioptions-=L
endif

""" }}}1
""" Section: Mappings {{{1

nnoremap <c-l> :tabn<cr>
nnoremap <c-h> :tabp<cr>

nnoremap <s-h> :bnext<cr>
nnoremap <s-l> :bprevious<cr>
nnoremap <c-n> :NERDTreeToggle<cr>

""" }}}1

