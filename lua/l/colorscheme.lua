local g = vim.g
local opt = require('l.utils').opt

opt('termguicolors')

g.oceanic_next_terminal_bold = 1
g.oceanic_next_terminal_italic = 1

vim.api.nvim_command('colorscheme OceanicNext')
