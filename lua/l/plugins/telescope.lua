require('telescope').setup {
    defaults = {
        prompt_prefix = '> ',
        selection_caret = '> ',
        entry_prefix = '  ',
        initial_mode = 'insert',
        selection_strategy = 'reset',
        sorting_strategy = 'descending',

        layout_strategy = 'vertical',
        layout_config = {
            vertical = {
                mirror = false
            }
        },

        winblend = 0,
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = false,
        set_env = {
            ['COLORTERM'] = 'truecolor'
        }, -- default = nil,

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
            override_generic_sorter = false,
            -- override the file sorter
            override_file_sorter = true,
            -- or 'ignore_case' or 'respect_case'
            -- the default case_mode is 'smart_case'
            case_mode = 'smart_case'
        }
    }
}

require('telescope').load_extension('fzf')
