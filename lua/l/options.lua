local o = vim.o

local opt = require('l.utils').opt

local buffer = { o, vim.bo }
local window = { o, vim.wo }
local global = { o, vim.go }

vim.api.nvim_set_option('termguicolors', true)

-- Indentation
opt('expandtab', true, buffer)
opt('shiftwidth', 2, buffer)
opt('tabstop', 2, buffer)
opt('softtabstop', 2, buffer)

-- Search
opt('ignorecase', true) -- Case insensitive search
opt('smartcase', true) -- But sensitive if includes capital letter
opt('hlsearch', false) -- Hide highlights after search

-- UI
opt('wrap', false, window)
opt('linebreak', true, window) -- Break lines by spaces or tabs
opt('breakindent', true, window)

opt('number', true, window)
opt('relativenumber', true, window)
opt('signcolumn', 'number', window) -- Merge signcolumn and number column into one
opt('showmode', false) -- Do not show mode in command line
opt('cmdheight', 1, global)

opt('list', true, window)
opt('listchars', {
  'nbsp:⦸', -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  'tab:  ', --
  'extends:»', -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  'precedes:«', -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  'trail:·', -- Dot Operator (U+22C5)
}, window)

-- Show cool character on line wrap
opt('showbreak', '↳ ') -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
opt('fillchars', 'eob: ') -- Suppress ~ at EndOfBuffer

opt 'cursorline' -- Highlight current line
opt 'showmatch' -- Hightlight matching parens

opt 'lazyredraw' -- Redraw only when need to
opt('laststatus', 2) -- Show 2 status lines for errors

opt('scrolloff', 5) -- Lines to scroll vertically
opt('sidescrolloff', 3) -- Lines to scroll horizontally

-- UX
opt('confirm', true)
opt('updatetime', 100)
opt('timeoutlen', 300)
opt('inccommand', 'split')
opt 'incsearch' -- Move cursor with search result

opt('mouse', 'a') -- Enable mouse usage
opt('splitright', true) -- Open new split to the right
opt('splitbelow', true) -- Open new split below
opt('backspace', { 'indent', 'eol', 'start' })
opt('whichwrap', 'b,s,h,l,<,>,[,]') -- Backspace and cursor keys wrap lines
opt('completeopt', { 'noinsert', 'menuone', 'noselect' })

-- Autoformatting
opt('formatoptions', {
  'c', -- Auto-wrap comments
  '2', -- Use the second line's indent vale when indenting (allows indented first line)
  'q', -- Formatting comments with `gq`
  'w', -- Trailing whitespace indicates a paragraph
  'j', -- Remove comment leader when makes sense (joining lines)
  'r', -- Insert comment leader after hitting Enter
  'o', -- Insert comment leader after hitting `o` or `O`
}, buffer)

-- Messages
local short_mess = 'filnxtToOF'
short_mess = short_mess .. 'W' -- Don't print "written" when editing
short_mess = short_mess .. 'a' -- Use abbreviations in messages ([RO] intead of [readonly])
short_mess = short_mess .. 'c' -- Do not show ins-completion-menu messages (match 1 of 2)
opt('shortmess', short_mess)

-- Integration with system clipboard
opt('clipboard', { 'unnamed', 'unnamedplus' })

opt('langmenu', 'en_US')
opt('foldmethod', 'indent')
opt('foldopen', { 'jump' })
opt('foldlevel', 99)

-- always show signcolumns
opt('signcolumn', 'yes')

-- Undo & History
opt('undofile', true)
opt('undolevels', 1000)
opt('undoreload', 10000)
opt('shada', "!,'1000,<50,s10,h") -- Increase the shadafile size so that history is longer

-- grep
opt('grepprg', 'rg --vimgrep')
