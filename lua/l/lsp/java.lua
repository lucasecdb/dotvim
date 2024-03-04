local status, _ = pcall(require, 'jdtls')

if not status then
  return
end

local home_dir = os.getenv 'HOME'

local java_home = os.getenv 'JAVA_HOME'

local mason_path = vim.fn.stdpath 'data' .. '/mason/packages'
local jdtls_dir = mason_path .. '/jdtls'
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

local bundles = {}

vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. '/vscode-java-decompiler/server/*.jar'), '\n'))

local config = {
  cmd = {
    jdtls_bin,
    '--jvm-arg=-Dlog.protocol=true',
    '--jvm-arg=-Dlog.level=ALL',
    '--jvm-arg=-javaagent:' .. local_lombok,
    '-data',
    workspace_dir,
  },

  root_dir = root_dir,

  settings = {
    java = {
      home = java_home,
      jdt = {
        ls = {
          java = {
            home = java_home,
          },
        },
      },
    },
  },

  init_options = {
    bundles = bundles,
  },
}

return config
