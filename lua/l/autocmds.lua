local configure = require('l.terminal.functions').configure

-- Terminal configuration
vim.api.nvim_create_autocmd('TermOpen', {callback = configure})
vim.api.nvim_create_autocmd('WinEnter', {callback = configure})
vim.api.nvim_create_autocmd('WinLeave', {callback = configure})
vim.api.nvim_create_autocmd('BufEnter', {callback = configure})
vim.api.nvim_create_autocmd('BufLeave', {callback = configure})

-- Format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = {'*.tsx', '*.jsx', '*.ts', '*.js', '*.mjs', '*.json', '*.lua', '*.vue'},
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 1000 })
  end
})

-- Automatically copy to clipboard
local function copy()
  if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
    require('osc52').copy_register('+')
  end
end

vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})
