local status, jdtls = pcall(require, 'jdtls')
local registry = require 'mason-registry'

if not status then
  return
end

local home_dir = os.getenv 'HOME'

local java_home = os.getenv 'JAVA_HOME'

local jdtls_package = registry.get_package 'jdtls'
local jdtls_dir = jdtls_package:get_install_path()

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

local java_debug_package = registry.get_package 'java-debug-adapter'
local java_test_package = registry.get_package 'java-test'
local vscode_java_decompiler_package = registry.get_package 'vscode-java-decompiler'

local bundles = {}

vim.list_extend(bundles, vim.fn.glob(vscode_java_decompiler_package:get_install_path() .. '/server/*.jar', true, true))

if java_debug_package:is_installed() then
  vim.list_extend(
    bundles,
    vim.fn.glob(
      vim.fs.joinpath(
        java_debug_package:get_install_path(),
        'extension',
        'server',
        'com.microsoft.java.debug.plugin-*.jar'
      ),
      true,
      true
    )
  )
end

if java_test_package:is_installed() then
  local package_json_path = vim.fs.joinpath(java_test_package:get_install_path(), 'extension', 'package.json')

  local package_json_pipe = io.open(package_json_path, 'r')

  if package_json_pipe ~= nil then
    local package_json_str = package_json_pipe:read '*a'

    local package_json = vim.json.decode(package_json_str)

    local extension_files = package_json['contributes']['javaExtensions']

    vim.tbl_map(function(file)
      local file_path = vim.fs.joinpath(java_test_package:get_install_path(), 'extension', file)

      vim.list_extend(bundles, { vim.fs.normalize(file_path) })
    end, extension_files)
  end
end

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
      format = {
        enabled = false,
      },
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-21',
            path = '~/.sdkman/candidates/java/21.0.4-tem/',
          },
          {
            name = 'JavaSE-17',
            path = '~/.sdkman/candidates/java/17.0.12-tem/',
          },
        },
      },
    },
  },

  init_options = {
    bundles = bundles,
  },

  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    vim.keymap.set('n', '<leader>df', jdtls.test_class, { buffer = bufnr, desc = '[D]ebug [F]ull' })
    vim.keymap.set('n', '<leader>dn', jdtls.test_nearest_method, { buffer = bufnr, desc = '[D]ebug [N]earest Method' })
  end,
}

return config
