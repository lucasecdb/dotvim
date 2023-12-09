vim.opt_local.expandtab = false

local port = os.getenv('GDScript_Port') or '6005'
local cmd = vim.lsp.rpc.connect('172.22.0.1', port)
local pipe = '/tmp/godot.pipe'

vim.lsp.start({
    name = 'Godot',
    cmd = cmd,
    root_dir = vim.fs.dirname(vim.fs.find({'project.godot', '.git'}, {
        upward = true,
        path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    })[1]),
    on_attach = function(client, bufnr)
        vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
    end
})
