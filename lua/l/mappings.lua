local t = require('l.utils').t
local check_back_space = require('l.utils').check_back_space

-- Normal mode

-- Split switching
vim.keymap.set('n', '<c-h>', '<c-w>h', {silent = true})
vim.keymap.set('n', '<c-j>', '<c-w>j', {silent = true})
vim.keymap.set('n', '<c-k>', '<c-w>k', {silent = true})
vim.keymap.set('n', '<c-l>', '<c-w>l', {silent = true})

-- Buffer switching
vim.keymap.set('n', '<s-l>', ':bnext<cr>', {silent = true})
vim.keymap.set('n', '<s-h>', ':bprevious<cr>', {silent = true})

-- Fugitive
vim.keymap.set('n', '<leader>c', ':Git commit<cr>', {silent = true})
vim.keymap.set('n', '<leader>s', ':Git<cr>', {silent = true})
vim.keymap.set('n', '<leader>p', ':Git push<cr>')

-- Fuzzy finder
local telescope = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff',
               function() telescope.find_files {hidden = true} end, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})
vim.keymap.set('n', '<leader>fv', telescope.treesitter, {})

-- Misc
vim.keymap.set('n', '<leader>q', ':q<cr>')
vim.keymap.set('n', '<leader>h', ':set hidden <bar> close<cr>')

-- Insert mode
vim.keymap.set('i', 'jk', '<esc>') -- Go back to normal mode with jk

local function smart_tab()
    if vim.fn.pumvisible() == 1 then return t '<c-n>' end

    if check_back_space() then return t '<tab>' end
end

local function shift_smart_tab()
    if vim.fn.pumvisible() == 1 then return t '<c-p>' end

    return t '<c-h>'
end

vim.keymap.set('i', '<tab>', smart_tab, {silent = true, expr = true})
vim.keymap.set('i', '<s-tab>', shift_smart_tab, {silent = true, expr = true})

-- Terminal mode
vim.keymap.set('t', 'jk', [[<c-\><c-n>]])

-- Visual mode
vim.keymap.set('v', '<leader>fg', ':!prettier --parser graphql<cr>')
vim.keymap.set('v', '<leader>fj', ':!prettier --parser babel<cr>')
vim.keymap.set('v', '<leader>ft', ':!fmt -80 -s<cr>')
