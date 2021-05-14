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
map('n', '<leader>c', ':Gcommit<cr>', { silent = true })
map('n', '<leader>s', ':Gstatus<cr>', { silent = true })
map('n', '<leader>p', ':Gpush<cr>')

-- Fuzzy finder
map('n', '<leader>t', ':GFiles && git ls-files -o --exclude-standard<cr>')

-- CoC
--   Remap keys for gotos
map('n', 'gd', '<Plug>(coc-definition)', { silent = true, noremap = false })
map('n', 'gy', '<Plug>(coc-type-definition)', { silent = true, noremap = false })
map('n', 'gi', '<Plug>(coc-implementation)', { silent = true, noremap = false })
map('n', 'gr', '<Plug>(coc-references)', { silent = true, noremap = false })

--   Use `[g` and `]g` to navigate diagnostics
map('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true, noremap = false })
map('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true, noremap = false })

function mappings.show_documentation()
  local ft = vim.bo.filetype
  local cword = vim.fn.expand('<cword>')

  if ft == 'help' or ft == 'vim' then
    vim.fn.execute('help ' .. cword)
  elseif vim.fn['coc#rpc#ready']() then
    vim.fn.call('CocActionAsync', {'doHover'})
  else
    vim.fn.execute(vim.o.keywordprg .. ' ' .. cword)
  end
end

--   Use `K` to show documentation
map('n', 'K', ':call v:lua._l.mappings.show_documentation()<cr>', { silent = true })

--   Remap keys for applying code action to the current buffer
map('n', '<leader>ac', '<Plug>(coc-codeaction)', { silent = true, noremap = false })
map('x', '<leader>ac', '<Plug>(coc-codeaction)', { silent = true, noremap = false })

--   Show commands
map('n', '<leader>oc', ':<C-u>CocList commands<cr>', { silent = true })

-- Misc
map('n', '<leader>q', ':q<cr>')
map('n', '<leader>h', ':set hidden <bar> close<cr>')


-- Insert mode

map('i', 'jk', '<esc>') -- Go back to normal mode with jk

map('i', '<c-space>', 'coc#refresh()', { silent = true, expr = true }) -- Use <c-space> to trigger completion.

function mappings.smart_tab()
  if vim.fn.pumvisible() == 1 then
    return t'<c-n>'
  end

  if check_back_space() then
    return t'<tab>'
  end

  return vim.fn['coc#refresh']()
end

function mappings.shift_smart_tab()
  if vim.fn.pumvisible() == 1 then
    return t'<c-p>'
  end

  return t'<c-h>'
end

map('i', '<tab>', 'v:lua._l.mappings.smart_tab()', { silent = true, expr = true })
map('i', '<s-tab>', 'v:lua._l.mappings.shift_smart_tab()', { silent = true, expr = true })

function mappings.handle_cr()
  if vim.fn.pumvisible() ~= 0 then
    return vim.fn['coc#_select_confirm']()
  end

  return t'<c-g>u<cr><c-r>=coc#on_enter()<cr>'
end

map('i', '<cr>', 'v:lua._l.mappings.handle_cr()', { silent = true, expr = true })


-- Terminal mode

map('t', 'jk', [[<c-\><c-n>]])


-- Visual mode

map('v', '<leader>fg', ':!prettier --parser graphql<cr>')
map('v', '<leader>fj', ':!prettier --parser babel<cr>')
map('v', '<leader>ft', ':!fmt -80 -s<cr>')

_G._l.mappings = mappings
