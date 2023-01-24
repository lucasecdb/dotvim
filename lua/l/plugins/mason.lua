local signature = require('lsp_signature')

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
        "eslint", "tsserver", "tailwindcss", "omnisharp", "sumneko_lua"
    }
})

-- LSP servers that must have document formatting capabilities disabled
local disable_format_servers = {"sumneko_lua", "tsserver"}

-- LSP servers that offer document formatting capabilities
local enable_format_servers = {"eslint"}

local function on_attach(client, bufnr)
    signature.on_attach({
        bind = true,
        hint_enable = true,
        hint_prefix = ' ',
        handler_opts = {border = 'rounded'}
    }, bufnr)

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    if client.config.flags then
        client.config.flags.allow_incremental_sync = true
        client.config.flags.debounce_text_changes = 100
    end

    if vim.tbl_contains(disable_format_servers, client.name) then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end

    if vim.tbl_contains(enable_format_servers, client.name) then
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true
    end

    local opts = {silent = true, noremap = false, buffer = bufnr}

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gc', vim.lsp.buf.rename, opts)
    --   Use `[g` and `]g` to navigate diagnostics
    vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts) -- Use `<leader>k` to show documentation
    --   Remap keys for applying code action to the current buffer
    vim.keymap.set('n', '<leader>ac', vim.lsp.buf.code_action, opts)
    vim.keymap.set('x', '<leader>ac', vim.lsp.buf.code_action, opts)

    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set('n', 'gq',
                       function() vim.lsp.buf.format {async = true} end, opts)
    end
    if client.server_capabilities.documentRangeFormattingProvider then
        vim.keymap.set('v', 'gq',
                       function() vim.lsp.buf.format {async = true} end, opts)
    end
end

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
        on_attach = on_attach
    }
end

require("mason-lspconfig").setup_handlers({
    function(server_name)
        local config = make_config()

        if server_name == 'sumneko_lua' then
            config.settings = lua_settings
        end
        if server_name == 'efm' then
            config = vim.tbl_extend('force', config, require 'l.lsp.efm')
            config.capabilities.textDocument.formatting = true
        end

        require("lspconfig")[server_name].setup(config)
    end
})
