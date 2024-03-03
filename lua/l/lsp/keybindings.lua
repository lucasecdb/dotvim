local M = {}

-- LSP servers that must have document formatting capabilities disabled
local disable_format_servers = { 'lua_ls', 'tsserver', 'volar' }

-- LSP servers that offer document formatting capabilities
local enable_format_servers = { 'eslint', 'efm', 'luaformatter' }

function M.on_attach(client, bufnr)
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

  local opts = { silent = true, noremap = false, buffer = bufnr }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gc', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts) -- Use `<leader>k` to show documentation
  --   Remap keys for applying code action to the current buffer
  vim.keymap.set('n', '<leader>ac', vim.lsp.buf.code_action, opts)
  vim.keymap.set('x', '<leader>ac', vim.lsp.buf.code_action, opts)

  if client.server_capabilities.documentFormattingProvider then
    vim.keymap.set('n', 'gq', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end
  if client.server_capabilities.documentRangeFormattingProvider then
    vim.keymap.set('v', 'gq', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end
end

return M
