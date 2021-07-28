_G._l = {}

local g = vim.g

g.mapleader = ' '

-- Personal configs
require('l.plugins')
require('l.options')
require('l.commands')
require('l.mappings')
require('l.statusline')
require('l.autocmds')
require('l.colorscheme')

-- Plugin configs
require('l.plugins.treesitter')
require('l.plugins.lsp')
require('l.plugins.which-key')
require('l.plugins.compe')
require('l.plugins.telescope')
