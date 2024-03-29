local t = require('l.utils').t
local check_back_space = require('l.utils').check_back_space

-- [[ Normal mode ]]

-- Diagnostics
-- Use `[g` and `]g` to navigate diagnostics
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, { desc = 'Go to previous dia[g]nostic message' })
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, { desc = 'Go to next dia[g]nostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show [d]iagnostic [e]rror messages' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open [d]iagnostic [q]uickfix list' })

-- Split switching
vim.keymap.set('n', '<c-h>', '<c-w><c-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<c-l>', '<c-w><c-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<c-j>', '<c-w><c-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<c-k>', '<c-w><c-k>', { desc = 'Move focus to the upper window' })

-- Buffer switching
vim.keymap.set('n', '<s-l>', ':bnext<cr>', { silent = true })
vim.keymap.set('n', '<s-h>', ':bprevious<cr>', { silent = true })

-- Misc
vim.keymap.set('n', '<leader>q', ':q<cr>', { silent = true })
vim.keymap.set('n', '<leader>h', ':set hidden <bar> close<cr>', { silent = true })

vim.keymap.set('n', '<leader>oh', ':e %:h<cr>', { silent = true })

-- Quickfix
vim.keymap.set('n', '<leader>co', ':copen<cr>', { silent = true })
vim.keymap.set('n', '<leader>cc', ':cclose<cr>', { silent = true })

-- [[ Insert mode ]]

vim.keymap.set('i', 'jk', '<esc>') -- Go back to normal mode with jk

local function smart_tab()
  if vim.fn.pumvisible() == 1 then
    return t '<c-n>'
  end

  if check_back_space() then
    return t '<tab>'
  end
end

local function shift_smart_tab()
  if vim.fn.pumvisible() == 1 then
    return t '<c-p>'
  end

  return t '<c-h>'
end

vim.keymap.set('i', '<tab>', smart_tab, { silent = true, expr = true })
vim.keymap.set('i', '<s-tab>', shift_smart_tab, { silent = true, expr = true })

-- [[ Terminal mode ]]

-- Exit terminal with jk, same as in insert mode on a regular buffer
vim.keymap.set('t', 'jk', [[<c-\><c-n>]])

-- [[ Visual mode ]]
vim.keymap.set('v', '<leader>fg', ':!prettier --parser graphql<cr>')
vim.keymap.set('v', '<leader>fj', ':!prettier --parser babel<cr>')
vim.keymap.set('v', '<leader>ft', ':!fmt -80 -s<cr>')
