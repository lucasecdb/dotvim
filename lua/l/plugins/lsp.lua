local debug_lsp = os.getenv 'LSP_DEBUG' ~= nil

if debug_lsp then
  vim.lsp.set_log_level 'debug'
end

require 'l.lsp.autocmd'

require('mason').setup {
  registries = {
    'lua:l.mason-registry.registry',
    'github:mason-org/mason-registry',
  },
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
    'volar',
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
      config = vim.tbl_extend('force', config, require 'l.lsp.lua')
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

require('lspconfig').gdscript.setup(vim.tbl_extend('force', make_config(), require 'l.lsp.godot'))
