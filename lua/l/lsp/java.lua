local status, jdtls = pcall(require, 'jdtls')

if not status then
  return
end

local lsp_binds = require 'l.lsp.keybindings'

local home_dir = os.getenv 'HOME'

local java_home = os.getenv 'JAVA_HOME'

local mason_path = vim.fn.stdpath 'data' .. '/mason/'
local jdtls_dir = mason_path .. 'packages/jdtls'
local jdtls_bin = jdtls_dir .. '/jdtls'

local local_lombok = jdtls_dir .. '/lombok.jar'

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home_dir .. '/.workspace/' .. project_name

vim.fn.mkdir(workspace_dir, 'p')

local root_markers = { 'gradlew', '.git', 'mvnw', 'settings.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers)
if root_dir == '' then
  return
end

local config = {
  cmd = {
    -- LuaFormatter off
    jdtls_bin,
    '--jvm-arg=-javaagent:' .. local_lombok,
    '-data',
    workspace_dir,
    -- LuaFormatter on
  },

  root_dir = root_dir,

  on_attach = lsp_binds.on_attach,

  settings = { java = { home = java_home } },
}

return config
