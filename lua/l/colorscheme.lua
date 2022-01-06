local g = vim.g
local opt = require('l.utils').opt

opt('termguicolors')

-- Oceanic
-- g.oceanic_next_terminal_bold = 1
-- g.oceanic_next_terminal_italic = 1

-- Gruvbox
-- vim.api.nvim_command('colorscheme gruvbox')

-- Nord
-- vim.g.nord_contrast = true
-- vim.g.nord_italic = true

-- require('nord').set()

-- Catppuccin
local catppuccin = require('catppuccin')

catppuccin.setup({
    transparent_background = false,
    term_colors = false,
    styles = {
        comments = "italic",
        functions = "italic",
        keywords = "italic",
        strings = "NONE",
        variables = "italic"
    },
    integrations = {
        treesitter = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = "italic",
                hints = "italic",
                warnings = "italic",
                information = "italic"
            },
            underlines = {
                errors = "underline",
                hints = "underline",
                warnings = "underline",
                information = "underline"
            }
        },
        lsp_trouble = false,
        cmp = true,
        lsp_saga = false,
        gitgutter = false,
        gitsigns = true,
        telescope = true,
        nvimtree = {
            enabled = false,
            show_root = false
        },
        which_key = true,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = false
        },
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
        telekasten = true
    }
})

vim.cmd [[colorscheme catppuccin]]
