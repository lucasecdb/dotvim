" vim: set foldmethod=marker foldlevel=0:

let g:coc_global_extensions = [
  \'coc-tsserver',
  \'coc-eslint',
  \'coc-css',
  \'coc-json',
  \'coc-texlab',
  \'coc-vimtex',
  \'coc-go',
  \'coc-omnisharp'
  \]

""" Section: Packages {{{1

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/jsonc.vim'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'lucasecdb/vim-codedark'
Plug 'vim-airline/vim-airline'
Plug 'udalov/kotlin-vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'jparise/vim-graphql'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'rust-lang/rust.vim'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'

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
set splitbelow
set splitright
set cursorline
set mouse=a
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
set completeopt+=noinsert
set nohls
set ignorecase
set updatetime=300

" Better display for messages
set cmdheight=2

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

set laststatus=2

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

""" }}}1
""" Section: Mappings {{{1

let mapleader=' '

inoremap jk <esc>

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
nnoremap <silent> <leader>h :set hidden <bar> close<cr>

""" Section: CoC {{{2

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

"""}}}2

" Fugitive
nnoremap <silent> <leader>c :Gcommit<cr>
nnoremap <silent> <leader>s :Gstatus<cr>
nnoremap <leader>p :Gpush<cr>

command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, {'options': ['--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']})

" Fuzzy finder
nnoremap <leader>t :GFiles && git ls-files -o --exclude-standard<cr>

" Terminal
tnoremap jk <c-\><c-n>

" Formatters
vnoremap <leader>fg :!prettier --stdin --stdin-filepath query.gql<cr>
vnoremap <leader>fj :!prettier --stdin --stdin-filepath module.js<cr>
vnoremap <leader>ft :!fmt -80 -s<cr>

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

let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_virtualtext_cursor = 1
let g:ale_linters = {
\  'python': ['flake8'],
\  'typescript': ['eslint', 'tsserver'],
\  'javascript': ['eslint', 'flow', 'flow-language-server'],
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

  augroup FTOptions
    autocmd!
    autocmd FileType gitcommit setlocal spell
    autocmd FileType python let b:ale_fixers=['autopep8']
    autocmd FileType javascript,typescript let b:ale_fixers=['eslint', 'prettier']
    autocmd FileType nginx setlocal indentexpr= |
          \ setlocal cindent |
          \ setlocal cinkeys-=0#
    autocmd FileType cs setlocal shiftwidth=4 |
          \ setlocal softtabstop=4
  augroup END
  augroup Coc
    autocmd!
    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')
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
