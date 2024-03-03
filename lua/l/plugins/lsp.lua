local debug_lsp = os.getenv 'LSP_DEBUG' ~= nil

if debug_lsp then
  vim.lsp.set_log_level 'debug'
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    vim.api.nvim_buf_set_option(event.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-T>.
    map('gd', vim.lsp.buf.definition, '[G]oto [d]efinition')

    -- Find references for the word under your cursor.
    map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

    map('gy', vim.lsp.buf.type_definition, '[G]oto t[y]pe')

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

    -- Fuzzy find all the symbols in your current workspace
    --  Similar to document symbols, except searches over your whole project.
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- Rename the variable under your cursor
    --  Most Language Servers support renaming across files, etc.
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Opens a popup that displays documentation about the word under your cursor
    --  See `:help K` for why this keymap
    map('K', vim.lsp.buf.hover, 'Hover documentation')

    -- Use `<leader>k` to show documentation
    map('<leader>k', vim.lsp.buf.signature_help, '')

    -- Execute code actions with <space>ac
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [a]ction')

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client then
      if client.server_capabilities.documentFormattingProvider then
        map('gq', function()
          vim.lsp.buf.format { async = true }
        end, '')
      end

      if client.server_capabilities.documentRangeFormattingProvider then
        vim.keymap.set('v', 'gq', function()
          vim.lsp.buf.format { async = true }
        end, { buffer = event.buf })
      end

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end
  end,
})

require 'l.lsp.godot'

require('mason').setup {
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
}

require('mason-lspconfig').setup {
  ensure_installed = {
    'eslint',
    'tsserver',
    'tailwindcss',
    'omnisharp',
    'lua_ls',
    'jdtls',
    'volar',
  },
}

-- Configure lua language server for neovim development
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = 'LuaJIT',
    },
    workspace = {
      checkThirdParty = false,
      -- Make the server aware of Neovim runtime files
      library = {
        '${3rd}/luv/library',
        unpack(vim.api.nvim_get_runtime_file('', true)),
      },
    },
    completion = { callSnippet = 'Replace' },
  },
}

-- LSP servers that must have document formatting capabilities disabled
local disable_format_servers = { 'lua_ls', 'tsserver', 'volar' }

-- LSP servers that offer document formatting capabilities
local enable_format_servers = { 'eslint', 'efm', 'luaformatter' }

local function on_attach(client)
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
end

local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

require('mason-lspconfig').setup_handlers {
  function(server_name)
    local config = make_config()

    if server_name == 'tsserver' then
      config = vim.tbl_extend('force', config, require 'l.lsp.tsserver')
    end
    if server_name == 'sumneko_lua' or server_name == 'lua_ls' then
      config.settings = lua_settings
    end
    if server_name == 'jdtls' then
      return
    end
    if server_name == 'volar' then
      config = vim.tbl_extend('force', config, require 'l.lsp.volar')
    end

    require('lspconfig')[server_name].setup(config)
  end,
}

require('lspconfig').godot_lsp.setup(make_config())
