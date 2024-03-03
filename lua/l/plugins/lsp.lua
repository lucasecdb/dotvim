local debug_lsp = os.getenv 'LSP_DEBUG' ~= nil

if debug_lsp then
  vim.lsp.set_log_level 'debug'
end

require 'l.lsp.godot'

local lsp_binds = require 'l.lsp.keybindings'

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

local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = lsp_binds.on_attach,
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
