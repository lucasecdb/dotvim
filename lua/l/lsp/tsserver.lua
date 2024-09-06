local plugins = {}
local filetypes = { 'typescript', 'javascript' }

local mason_registry = require 'mason-registry'
local vue_language_server_pkg = mason_registry.get_package 'vue-language-server'

if vue_language_server_pkg:is_installed() then
  local vue_lsp_path = vue_language_server_pkg:get_install_path() .. '/node_modules/@vue/language-server'

  table.insert(plugins, {
    name = '@vue/typescript-plugin',
    location = vue_lsp_path,
    languages = { 'javascript', 'typescript', 'vue' },
  })

  table.insert(filetypes, 'vue')
end

return {
  root_dir = function(fname)
    return vim.fs.dirname(vim.fs.find({
      'tsconfig.json',
      'package.json',
      'jsconfig.json',
      '.git',
    }, { upward = true, path = vim.fs.dirname(fname) })[1])
  end,
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
