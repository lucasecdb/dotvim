local plugins = {}
local filetypes = { 'typescript', 'javascript' }

local mason_registry = require 'mason-registry'
local vue_language_server_pkg = mason_registry.get_package 'vue-language-server'

if vue_language_server_pkg:is_installed() then
  local vue_lsp_path = vim.fn.expand '$MASON/packages/vue-language-server/node_modules/@vue/language-server'

  table.insert(plugins, {
    name = '@vue/typescript-plugin',
    location = vue_lsp_path,
    languages = { 'javascript', 'typescript', 'vue' },
  })

  table.insert(filetypes, 'vue')
end

return {
  init_options = {
    plugins = plugins,
  },
  filetypes = filetypes,
  handlers = {
    ['$/typescriptVersion'] = function(err, result)
      if err ~= nil then
        return
      end

      vim.b.lualine_ts_version = result.version
    end,
  },
}
