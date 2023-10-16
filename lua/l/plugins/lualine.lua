local function ts_version()
    local version = vim.g.lualine_ts_version

    if version ~= nil then return string.format('v%s', version) end

    return ''
end

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
        lualine_x = {'searchcount', 'selectioncount', 'filetype', ts_version},
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
