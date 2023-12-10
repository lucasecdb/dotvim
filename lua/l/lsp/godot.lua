local configs = require 'lspconfig.configs'

-- Check if the config is already defined (useful when reloading this file)
if not configs.godot_lsp then
    local uv = require("luv")
    local hostname = vim.fn.hostname() .. '.local'
    local ip_address = uv.getaddrinfo(hostname)[1]['addr']

    local port = os.getenv('GDScript_Port') or '6005'
    local cmd = vim.lsp.rpc.connect(ip_address, port)

    configs.godot_lsp = {
        default_config = {
            name = 'godot',
            cmd = cmd,
            filetypes = {'gdscript'},
            root_dir = function(fname)
                return vim.fs.dirname(vim.fs.find({'project.godot', '.git'}, {
                    upward = true,
                    path = vim.fs.dirname(fname)
                })[1])
            end,
            settings = {}
        }
    }
end
