local opt = require('l.utils').opt

opt 'termguicolors'

local catppuccin = require 'catppuccin'

catppuccin.setup {
  flavour = 'mocha',
  transparent_background = false,
  term_colors = false,
  styles = {
    comments = { 'italic' },
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
  },
  highlight_overrides = {
    mocha = function(mocha)
      local line_nr = mocha.overlay1

      return {
        LineNr = { fg = line_nr },
        LineNrAbove = { fg = line_nr },
        LineNrBelow = { fg = line_nr },
      }
    end,
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { 'italic' },
        hints = { 'italic' },
        warnings = { 'italic' },
        information = { 'italic' },
      },
      underlines = {
        errors = { 'underline' },
        hints = { 'underline' },
        warnings = { 'underline' },
        information = { 'underline' },
      },
    },
    lsp_trouble = false,
    cmp = true,
    lsp_saga = false,
    gitgutter = false,
    gitsigns = true,
    telescope = true,
    nvimtree = { enabled = false, show_root = false },
    which_key = true,
    indent_blankline = { enabled = true, colored_indent_levels = false },
    dashboard = true,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    bufferline = true,
    markdown = true,
    lightspeed = false,
    ts_rainbow = false,
    hop = false,
    notify = true,
    telekasten = true,
  },
}

vim.cmd [[colorscheme catppuccin-mocha]]
