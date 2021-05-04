local map = require('l.utils').map

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
map('n', '[g', '<Plug>(coc-diagnostics-prev)', { silent = true, noremap = false })
map('n', 'g]', '<Plug>(coc-diagnostics-next)', { silent = true, noremap = false })

--   Use `K` to show documentation
-- map('n', 'K', ':call <SID>show_documentation()<cr>', { silent = true })

--[[
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
--]]

--   Remap keys for applying code action to the current buffer
map('n', '<leader>ac', '<Plug>(coc-codeaction)', { silent = true })

--   Show commands
map('n', '<leader>oc', ':<C-u>CocList commands<cr>', { silent = true })

-- Misc
map('n', '<leader>q', ':q<cr>')
map('n', '<leader>h', ':set hidden <bar> close<cr>')


-- Insert mode

map('i', 'jk', '<esc>') -- Go back to normal mode with jk

map('i', '<c-space>', 'coc#refresh()', { silent = true, expr = true }) -- Use <c-space> to trigger completion.


-- Terminal mode

map('t', 'jk', [[<c-\><c-n>]])


-- Visual mode

map('v', '<leader>fg', ':!prettier --parser graphql<cr>')
map('v', '<leader>fj', ':!prettier --parser babel<cr>')
map('v', '<leader>ft', ':!fmt -80 -s<cr>')
