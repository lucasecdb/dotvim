require('nvim-treesitter').install {
  'query',
  'typescript',
  'javascript',
  'tsx',
  'json',
  'lua',
  'bash',
  'vue',
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(ev.match)
    if lang and vim.list_contains(require('nvim-treesitter').get_installed(), lang) then
      vim.treesitter.start()
    end
  end,
})

local select = require 'nvim-treesitter-textobjects.select'
local move = require 'nvim-treesitter-textobjects.move'
local swap = require 'nvim-treesitter-textobjects.swap'
local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'

-- stylua: ignore start
-- Select
vim.keymap.set({ 'x', 'o' }, 'ac', function() select.select_textobject('@class.outer') end, { desc = 'Select outer part of class region' })
vim.keymap.set({ 'x', 'o' }, 'ic', function() select.select_textobject('@class.inner') end, { desc = 'Select inner part of class region' })
vim.keymap.set({ 'x', 'o' }, 'ab', function() select.select_textobject('@block.outer') end)
vim.keymap.set({ 'x', 'o' }, 'ib', function() select.select_textobject('@block.inner') end)
vim.keymap.set({ 'x', 'o' }, 'af', function() select.select_textobject('@function.outer') end, { desc = 'Select outer part of function region' })
vim.keymap.set({ 'x', 'o' }, 'if', function() select.select_textobject('@function.inner') end, { desc = 'Select inner part of function region' })
vim.keymap.set({ 'x', 'o' }, 'ap', function() select.select_textobject('@parameter.outer') end, { desc = 'Select outer part of parameter list' })
vim.keymap.set({ 'x', 'o' }, 'ip', function() select.select_textobject('@parameter.inner') end, { desc = 'Select inner part of parameter list' })

-- Swap
vim.keymap.set('n', '<leader>a', function() swap.swap_next('@parameter.inner') end)
vim.keymap.set('n', '<leader>A', function() swap.swap_previous('@parameter.inner') end)

-- Move
vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() move.goto_next_start('@function.outer') end, { desc = 'Next function start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() move.goto_next_start('@class.outer') end, { desc = 'Next class start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() move.goto_previous_start('@function.outer') end, { desc = 'Previous function start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() move.goto_previous_start('@class.outer') end, { desc = 'Previous class start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']M', function() move.goto_next_end('@function.outer') end, { desc = 'Next function end' })
vim.keymap.set({ 'n', 'x', 'o' }, '][', function() move.goto_next_end('@class.outer') end, { desc = 'Next class end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[M', function() move.goto_previous_end('@function.outer') end, { desc = 'Previous function end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() move.goto_previous_end('@class.outer') end, { desc = 'Previous class end' })

-- Repeat movement with ; and ,
vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

-- Make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
-- stylua: ignore end
