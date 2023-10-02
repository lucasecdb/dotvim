local g = vim.g

g.mapleader = ' '

-- Personal configs
require('l.packer')
require('l.options')
require('l.commands')
require('l.keybindings')
require('l.autocmds')
