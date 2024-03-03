local disable_line_num = require('l.terminal.functions').disable_line_num

-- Terminal configuration
vim.api.nvim_create_autocmd('TermOpen', { callback = disable_line_num })
vim.api.nvim_create_autocmd('WinEnter', { callback = disable_line_num })
vim.api.nvim_create_autocmd('WinLeave', { callback = disable_line_num })
vim.api.nvim_create_autocmd('BufEnter', { callback = disable_line_num })
vim.api.nvim_create_autocmd('BufLeave', { callback = disable_line_num })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
