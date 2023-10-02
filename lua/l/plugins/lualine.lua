require('lualine').setup({
    options = {
        theme = "catppuccin",
        section_separators = {left = '', right = ''},
        component_separators = {left = '', right = ''}
    },
    extensions = {'quickfix'},
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'FugitiveHead', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'searchcount', 'selectioncount', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'%f'},
        lualine_x = {'filetype'},
        lualine_y = {},
        lualine_z = {}
    }
})
