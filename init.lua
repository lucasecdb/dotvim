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
