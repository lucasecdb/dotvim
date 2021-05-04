local g = vim.g

g.mapleader = ' '

-- Coc configuration must be run before plugin install
require('l.plugins.coc')

-- Personal configs
require('l.plugins')
require('l.options')
require('l.commands')
require('l.mappings')
require('l.statusline')

-- Plugin configs
require('l.plugins.treesitter')
require('codedark').setup()
