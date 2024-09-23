local M = {}

-- LSP servers that must have document formatting capabilities disabled
local disable_format_servers = { 'lua_ls', 'ts_ls', 'volar' }

-- LSP servers that offer document formatting capabilities
local enable_format_servers = { 'eslint', 'efm', 'luaformatter' }

function M.on_attach(client)
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

function M.make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = M.on_attach,
  }
end

return M
