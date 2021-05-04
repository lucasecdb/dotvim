local o = vim.o

local opt = require('l.utils').opt

local buffer = {o, vim.bo}
local window = {o, vim.wo}

-- Indentation
opt('expandtab', true, buffer)
opt('shiftwidth', 2, buffer)
opt('tabstop', 2, buffer)
opt('softtabstop', 2, buffer)
opt('autoindent')

-- Search
opt('ignorecase') -- Case insensitive search
opt('smartcase')  -- But sensitive if includes capital letter
opt('hlsearch', false) -- Hide highlights after search

-- UI
opt('wrap', false, window)
opt('linebreak', true, window) -- Break lines by spaces or tabs

opt('number', true, window)
opt('relativenumber', true, window)
opt('signcolumn', 'number', window) -- Merge signcolumn and number column into one
opt('showmode', false) -- Do not show mode in command line

opt('list', true, window)
opt('listchars', {
  'nbsp:⦸',  -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  'tab:  ',
  'extends:»',  -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  'precedes:«',  -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  'trail:·',  -- Dot Operator (U+22C5)
}, window)
-- Show cool character on line wrap
opt('showbreak', '↳ ')  -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
opt('fillchars', 'eob: ')  -- Suppress ~ at EndOfBuffer

opt('cursorline') -- Highlight current line
opt('showmatch') -- Hightlight matching parens

opt('lazyredraw')  -- Redraw only when need to
opt('laststatus', 2) -- Show 2 status lines for errors

opt('scrolloff', 3) -- Keep 3 lines of distance from top and bottom scroll

-- UX
opt('confirm')
opt('updatetime', 100)
opt('inccommand', 'nosplit')
opt('incsearch') -- Move cursor with search result

opt('mouse', 'a') -- Enable mouse usage
opt('splitright') -- Open new split to the right
opt('splitbelow') -- Open new split below
opt('backspace', {'indent','eol','start'})
opt('whichwrap', 'b,s,h,l,<,>,[,]') -- Backspace and cursor keys wrap lines
opt('completeopt', {'noinsert', 'menuone', 'noselect'})

-- Integration with system clipboard
opt('clipboard', {'unnamed', 'unnamedplus'})

opt('langmenu', 'en_US')
opt('foldmethod', 'indent')
opt('foldopen', {'jump'})
opt('foldlevel', 99)

-- Better display for messages
opt('cmdheight', 2)

-- always show signcolumns
opt('signcolumn', 'yes')
