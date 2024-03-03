local neogit = require 'neogit'

neogit.setup {}

-- Keybindings
vim.keymap.set('n', '<leader>gc', function()
  neogit.open { 'commit' }
end)
vim.keymap.set('n', '<leader>gg', function()
  neogit.open()
end)
