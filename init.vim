packadd minpac

call minpac#init({ 'verbose': 3 })

""" Section: Packages {{{1

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
call minpac#add('wincent/command-t')
call minpac#add('Shougo/deoplete.nvim')
call minpac#add('zchee/deoplete-jedi')

""" }}}1
""" Section: Options {{{1

set langmenu=en_US
let $LANG='en_US'
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set foldmethod=marker
set foldopen+=jump
set number
set backspace=indent,eol,start
set clipboard=unnamedplus
set scrolloff=3
set laststatus=2

""" }}}1
""" Section: Mappings {{{1

let mapleader=','

nnoremap <c-l> :tabn<cr>
nnoremap <c-h> :tabp<cr>
nnoremap <s-h> :bnext<cr>
nnoremap <s-l> :bprevious<cr>
nnoremap <c-n> :NERDTreeToggle<cr>
nnoremap <silent> <leader><Space> :set nohls<cr>

""" }}}1
""" Section: Plugins options {{{1

let g:flow#enable=0

let g:airline_powerline_fonts=1
let g:airline_theme='codedark'
let g:airline_left_sep=''
let g:airline_right_sep=''

let g:ale_completion_enabled=1

let g:CommandTAcceptSelectionMap = '<C-t>'
let g:CommandTAcceptSelectionTabMap = '<CR>'
let g:CommandTFileScanner='git'

let g:deoplete#enable_at_startup=1

"""}}}
""" Section: Autocommands {{{1

if has('autocmd')
  filetype indent plugin on

  augroup FTCheck " {{{2
    autocmd!
    autocmd BufRead,BufNewFile *.nginx,*/etc/nginx/*,*/usr/local/nginx/conf/*,nginx.conf set ft=nginx
  augroup END " }}}2
  augroup FTOptions " {{{2
    autocmd!
    autocmd FileType gitcommit setlocal spell
    autocmd FileType python let b:ale_linters=['flake8'] | let b:ale_fixers=['autopep8']
    autocmd FileType nginx setlocal indentexpr= |
          \ setlocal cindent |
          \ setlocal cinkeys-=0#
    autocmd FileType cs setlocal shiftwidth=4 |
          \ setlocal softtabstop=4
  augroup END " }}}2
endif

"""}}}1
""" Section: Visual {{{1

if has('syntax')
  if !has('syntax_on') && !exists('syntax_manual')
    syntax on
  endif

  if has('gui')
    set linespace=3
    set guioptions-=r
    set guioptions-=L
  endif

  set termguicolors
  set background=dark
  colorscheme codedark
endif

"""}}}1

