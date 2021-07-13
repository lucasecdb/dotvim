local map = require('l.utils').map
local t = require('l.utils').t
local check_back_space = require('l.utils').check_back_space

local mappings = {}

-- Normal mode

-- Split switching
map('n', '<c-h>', '<c-w>h', { silent = true })
map('n', '<c-j>', '<c-w>j', { silent = true })
map('n', '<c-k>', '<c-w>k', { silent = true })
map('n', '<c-l>', '<c-w>l', { silent = true })

-- Buffer switching
map('n', '<s-l>', ':bnext<cr>', { silent = true })
map('n', '<s-h>', ':bprevious<cr>', { silent = true })

-- Fugitive
map('n', '<leader>c', ':Git commit<cr>', { silent = true })
map('n', '<leader>s', ':Git<cr>', { silent = true })
map('n', '<leader>p', ':Git push<cr>')

-- Fuzzy finder
map('n', '<leader>t', ':GFiles && git ls-files -o --exclude-standard<cr>')

-- Misc
map('n', '<leader>q', ':q<cr>')
map('n', '<leader>h', ':set hidden <bar> close<cr>')

-- Insert mode
map('i', 'jk', '<esc>') -- Go back to normal mode with jk
map('i', '<c-space>', 'compe#complete()', { silent = true, expr = true }) -- Use <c-space> to trigger completion.
map('i', '<cr>', 'compe#confirm(\'<CR>\')', { silent = true, expr = true })
map('i', '<c-e>', 'compe#close(\'<C-e>\')', { silent = true, expr = true })
map('i', '<c-f>', 'compe#scroll({ \'delta\': -4 })', { silent = true, expr = true })
map('i', '<c-d>', 'compe#scroll({ \'delta\': +4 })', { silent = true, expr = true })

function mappings.smart_tab()
  if vim.fn.pumvisible() == 1 then
    return t'<c-n>'
  end

  if check_back_space() then
    return t'<tab>'
  end
end

function mappings.shift_smart_tab()
  if vim.fn.pumvisible() == 1 then
    return t'<c-p>'
  end

  return t'<c-h>'
end

map('i', '<tab>', 'v:lua._l.mappings.smart_tab()', { silent = true, expr = true })
map('i', '<s-tab>', 'v:lua._l.mappings.shift_smart_tab()', { silent = true, expr = true })


-- Terminal mode
map('t', 'jk', [[<c-\><c-n>]])


-- Visual mode
map('v', '<leader>fg', ':!prettier --parser graphql<cr>')
map('v', '<leader>fj', ':!prettier --parser babel<cr>')
map('v', '<leader>ft', ':!fmt -80 -s<cr>')

_G._l.mappings = mappings
