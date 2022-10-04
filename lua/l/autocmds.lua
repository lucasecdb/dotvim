require('l.utils').create_augroups {
    terminal = {
        {'TermOpen', '*', [[lua require('l.terminal.functions').configure()]]},
        {'WinEnter', '*', [[lua require('l.terminal.functions').configure()]]},
        {'WinLeave', '*', [[lua require('l.terminal.functions').configure()]]},
        {'BufEnter', '*', [[lua require('l.terminal.functions').configure()]]},
        {'BufLeave', '*', [[lua require('l.terminal.functions').configure()]]}
    },
    yank = {
        {
            'TextYankPost', '*',
            [[if v:event.operator is 'y' && v:event.regname is '' | OSCYankReg " | endif]]
        }
    },
    format_on_save = {
        {
            'BufWritePre', '*.tsx',
            [[lua vim.lsp.buf.format({ timeout_ms = 1000 })]]
        },
        {
            'BufWritePre', '*.jsx',
            [[lua vim.lsp.buf.format({ timeout_ms = 1000 })]]
        },
        {
            'BufWritePre', '*.ts',
            [[lua vim.lsp.buf.format({ timeout_ms = 1000 })]]
        },
        {
            'BufWritePre', '*.js',
            [[lua vim.lsp.buf.format({ timeout_ms = 1000 })]]
        },
        {
            'BufWritePre', '*.mjs',
            [[lua vim.lsp.buf.format({ timeout_ms = 1000 })]]
        },
        {
            'BufWritePre', '*.json',
            [[lua vim.lsp.buf.format({ timeout_ms = 1000 })]]
        },
        {
            'BufWritePre', '*.lua',
            [[lua vim.lsp.buf.format({ timeout_ms = 1000 })]]
        }
    }
}
