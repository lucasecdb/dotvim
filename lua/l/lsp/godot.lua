local configs = require('lspconfig.configs')

-- Check if the config is already defined (useful when reloading this file)
if not configs.godot_lsp then
    configs.godot_lsp = {
        default_config = {
            name = 'godot',
            cmd = {'godot-wsl-lsp'},
            filetypes = {'gdscript'},
            root_dir = function(fname)
                return vim.fs.dirname(vim.fs.find({'project.godot', '.git'}, {
                    upward = true,
                    path = vim.fs.dirname(fname)
                })[1])
            end,
            handlers = {
                ['gdscript_client/changeWorkspace'] = function(err, result)
                    if err then return end

                    local path = result['path']

                    vim.fn('cd', path)
                end
            }
        }
    }
end
