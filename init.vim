" vim: set foldmethod=marker foldlevel=0:

" This setting must be set before ALE is loaded.
let g:ale_completion_enabled = 1

call plug#begin('~/.vim/plugged')

""" Section: Packages {{{1

Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'lucasecdb/vim-codedark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jparise/vim-graphql'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'lucasecdb/vim-tsx'

call plug#end()

""" }}}1
""" Section: Options {{{1

set langmenu=en_US
let $LANG='en_US'
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set incsearch
set nohlsearch
set foldmethod=indent
set foldopen+=jump
set foldlevel=99
set number relativenumber
set backspace=indent,eol,start
set clipboard=unnamedplus
set scrolloff=3
set laststatus=2
set splitbelow
set splitright
set cursorline
set mouse=a
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
set completeopt+=noinsert

""" }}}1
""" Section: Mappings {{{1

let mapleader=','

" Window switching
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <c-l> <c-w>l

" Buffer switching
nnoremap <silent> <s-l> :bnext<cr>
nnoremap <silent> <s-h> :bprevious<cr>

" Misc
nnoremap <silent> <leader>q :q<cr>
nnoremap <silent> <leader>e :ALEFix eslint<cr>
nnoremap <silent> <leader>h :set hidden <bar> close<cr>
nnoremap <silent> <leader>d :ALEDetail<cr>
nnoremap <c-]> :ALEGoToDefinition<cr>

" Fugitive
nnoremap <silent> <leader>c :Gcommit<cr>
nnoremap <silent> <leader>s :Gstatus<cr>
nnoremap <leader>p :Gpush<cr>

" Fuzzy finder
nnoremap <leader>t :GFiles && git ls-files -o --exclude-standard<cr>

" Terminal
tnoremap <esc> <c-\><c-n>

command! WQ wq
command! Wq wq
command! W w
command! Q q

""" }}}1
""" Section: Plugins options {{{1

let g:airline_powerline_fonts = 1
let g:airline_theme = 'codedark'
let g:airline_left_sep = ''
let g:airline_right_sep = ''

let g:javascript_plugin_jsdoc = 1

let g:ale_virtualtext_cursor = 1
let g:ale_linters = {
\  'python': ['flake8'],
\  'typescript': ['eslint', 'tslint', 'tsserver'],
\  'javascript': ['eslint', 'flow'],
\  'graphql': ['gqlint']
\}

"""}}}
""" Section: Functions {{{1

function! CheckTermAndDisableNumber()
  if &buftype ==# "terminal"
    setlocal nonumber norelativenumber
  endif
endfunc

"""}}}1
""" Section: Autocommands {{{1

if has('autocmd')
  filetype indent plugin on

  augroup FTCheck
    autocmd!
    autocmd BufRead,BufNewFile *.nginx,*/etc/nginx/*,*/usr/local/nginx/conf/*,nginx.conf set ft=nginx
    autocmd BufRead,BufNewFile *.tsx set ft=typescript.tsx
    autocmd BufRead,BufNewFile *.js set ft=javascript.jsx
  augroup END
  augroup FTOptions
    autocmd!
    autocmd FileType gitcommit setlocal spell
    autocmd FileType python let b:ale_fixers=['autopep8']
    autocmd FileType javascript let b:ale_fixers=['eslint', 'prettier']
    autocmd FileType nginx setlocal indentexpr= |
          \ setlocal cindent |
          \ setlocal cinkeys-=0#
    autocmd FileType cs setlocal shiftwidth=4 |
          \ setlocal softtabstop=4
  augroup END
  if has('nvim')
    augroup Term
      autocmd!
      autocmd TermOpen * :call CheckTermAndDisableNumber()
      autocmd WinLeave * :call CheckTermAndDisableNumber()
      autocmd WinEnter * :call CheckTermAndDisableNumber()
      autocmd BufEnter * :call CheckTermAndDisableNumber()
      autocmd BufLeave * :call CheckTermAndDisableNumber()
    augroup END
  endif
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

