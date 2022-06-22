local map = require('l.utils').buf_map

local signature = require('lsp_signature')

local function on_attach(client, bufnr)
    signature.on_attach({
        bind = true,
        hint_enable = true,
        hint_prefix = ' ',
        handler_opts = {
            border = 'rounded'
        }
    }, bufnr)

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    if client.config.flags then
        client.config.flags.allow_incremental_sync = true
        client.config.flags.debounce_text_changes = 100
    end

    if client.name == 'tsserver' then
        client.server_capabilities.documentFormattingProvider = false
    end

    if client.name == 'eslint' then
        client.server_capabilities.documentFormattingProvider = true
    end

    local opts = {
        silent = true,
        noremap = false
    }

    map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    map(bufnr, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    map(bufnr, 'n', 'gc', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    --   Use `[g` and `]g` to navigate diagnostics
    map(bufnr, 'n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    map(bufnr, 'n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    map(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
        opts) -- Use `<leader>k` to show documentation
    --   Remap keys for applying code action to the current buffer
    map(bufnr, 'n', '<leader>ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    map(bufnr, 'x', '<leader>ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

    if client.server_capabilities.documentFormattingProvider then
        map(bufnr, 'n', 'gq', [[<cmd>lua vim.lsp.buf.format { async = true }<CR>]], opts)
    end
    if client.server_capabilities.documentRangeFormattingProvider then
        map(bufnr, 'v', 'gq', [[<cmd>lua vim.lsp.buf.format { async = true }<CR>]], opts)
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

-- config that activates keymaps and enables snippet support
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

local function setup_servers()
    local lsp_installer = require("nvim-lsp-installer")

    lsp_installer.on_server_ready(function(server)
        local config = make_config()

        if server.name == 'lua' then config.settings = lua_settings end
        if server.name == 'efm' then
            config = vim.tbl_extend('force', config, require 'l.lsp.efm')
            config.capabilities.textDocument.formatting = true
        end

        server:setup(config)
        vim.cmd [[ do User LspAttachBuffers ]]
    end)
end

setup_servers()
