local g = vim.g

g.mapleader = ' '

-- Personal configs
require('l.packer')
require('l.options')
require('l.commands')
require('l.mappings')
require('l.statusline')
require('l.autocmds')
require('l.colorscheme')
require('l.clipboard')

-- Plugin configs
require('l.plugins.treesitter')
require('l.plugins.which-key')
require('l.plugins.cmp')
require('l.plugins.telescope')
require('l.plugins.surround')
require('l.plugins.mason')
