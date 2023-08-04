require('telescope').setup {
    defaults = {
        prompt_prefix = '> ',
        selection_caret = '> ',
        entry_prefix = '  ',
        initial_mode = 'insert',
        selection_strategy = 'reset',
        sorting_strategy = 'descending',

        layout_strategy = 'flex',
        layout_config = {vertical = {mirror = false}, center = {mirror = false}},
        scroll_strategy = 'cycle',

        winblend = 0,
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = false,
        set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,

        path_display = {'truncate'},

        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        vimgrep_arguments = {
            'rg', '--color=never', '--no-heading', '--with-filename',
            '--line-number', '--column', '--smart-case', '--hidden'
        }
    },
    extensions = {
        fzf = {
            -- false will only do exact matching
            fuzzy = true,
            -- override the generic sorter
            override_generic_sorter = true,
            -- override the file sorter
            override_file_sorter = true,
            -- or 'ignore_case' or 'respect_case'
            -- the default case_mode is 'smart_case'
            case_mode = 'smart_case'
        },
        file_browser = {
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true
        }
    }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
