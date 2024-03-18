local debug_lsp = os.getenv 'LSP_DEBUG' ~= nil

if debug_lsp then
  vim.lsp.set_log_level 'debug'
end

require 'l.lsp.autocmd'
local lsp_options = require 'lua.l.lsp.options'

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
    'jdtls',
  },
}

require('mason-lspconfig').setup_handlers {
  function(server_name)
    local config = lsp_options.make_config()

    if server_name == 'tsserver' then
      config = vim.tbl_extend('force', config, require 'l.lsp.tsserver')
    end
    if server_name == 'sumneko_lua' or server_name == 'lua_ls' then
      config = vim.tbl_extend('force', config, require 'l.lsp.lua')
    end
    if server_name == 'jdtls' then
      -- JDTLS is configured separately using nvim-jdtls
      return
    end
    if server_name == 'volar' then
      config = vim.tbl_extend('force', config, require 'l.lsp.volar')
    end

    require('lspconfig')[server_name].setup(config)
  end,
}

require('lspconfig').gdscript.setup(vim.tbl_extend('force', lsp_options.make_config(), require 'l.lsp.godot'))
