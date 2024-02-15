require("l.lsp.godot")

local lsp_binds = require("l.lsp.keybindings")

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "eslint", "tsserver", "tailwindcss", "omnisharp", "lua_ls", "efm",
        "jdtls", "volar"
    }
})

-- Configure lua language server for neovim development
local lua_settings = {
    Lua = {
        runtime = {
            -- LuaJIT in the case of Neovim
            version = 'LuaJIT',
            path = vim.split(package.path, ';')
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'}
        },
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
            }
        }
    }
}

local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {
        -- enable snippet support
        capabilities = capabilities,
        -- map buffer local keybindings when the language server attaches
        on_attach = lsp_binds.on_attach
    }
end

require("mason-lspconfig").setup_handlers({
    function(server_name)
        local config = make_config()

        if server_name == 'tsserver' then
            config = vim.tbl_extend('force', config, require 'l.lsp.typescript')
        end
        if server_name == 'sumneko_lua' or server_name == 'lua_ls' then
            config.settings = lua_settings
        end
        if server_name == 'efm' then
            config = vim.tbl_extend('force', config, require 'l.lsp.efm')
            config.capabilities.textDocument.formatting = true
        end
        if server_name == 'jdtls' then return end
        if server_name == 'volar' then
            config = vim.tbl_extend('force', config, require 'l.lsp.vue')
        end

        require("lspconfig")[server_name].setup(config)
    end
})

require("lspconfig").godot_lsp.setup(make_config())
