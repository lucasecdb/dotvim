local debug_lsp = os.getenv 'LSP_DEBUG' ~= nil

if debug_lsp then
  vim.lsp.set_log_level 'debug'
end

require 'l.lsp.autocmd'
local lsp_options = require 'l.lsp.options'

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
  automatic_enable = {
    -- JDTLS is configured separately using nvim-jdtls
    exclude = { 'jdtls' },
  },
  ensure_installed = {
    'eslint',
    'jdtls',
    'lua_ls',
    'omnisharp',
    'phpactor',
    'tailwindcss',
    'ts_ls',
    'vue_ls',
  },
}

local function configure_lsp(lsp_name, config_override)
  vim.lsp.config(lsp_name, vim.tbl_extend('force', lsp_options.make_config(), config_override))
end

configure_lsp('ts_ls', require 'l.lsp.tsserver')
configure_lsp('lua_ls', require 'l.lsp.lua')
configure_lsp('vue_ls', require 'l.lsp.volar')

require('lspconfig').gdscript.setup(vim.tbl_extend('force', lsp_options.make_config(), require 'l.lsp.godot'))
