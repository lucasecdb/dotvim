local status, _ = pcall(require, 'jdtls')
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
  local files = {
    'junit-jupiter-api_*.jar',
    'junit-jupiter-engine_*.jar',
    'junit-jupiter-migrationsupport_*.jar',
    'junit-jupiter-params_*.jar',
    'junit-platform-commons_*.jar',
    'junit-platform-engine_*.jar',
    'junit-platform-launcher_*.jar',
    'junit-platform-runner_*.jar',
    'junit-platform-suite-api_*.jar',
    'junit-platform-suite-commons_*.jar',
    'junit-platform-suite-engine_*.jar',
    'junit-vintage-engine_*.jar',
    'org.apiguardian.api_*.jar',
    'org.eclipse.jdt.junit4.runtime_*.jar',
    'org.eclipse.jdt.junit5.runtime_*.jar',
    'org.opentest4j_*.jar',
    'org.jacoco.core_*.jar',
    'com.microsoft.java.test.plugin-*.jar',
  }

  vim.tbl_map(function(file_glob)
    local file_list =
      vim.fn.glob(vim.fs.joinpath(java_test_package:get_install_path(), 'extension', 'server', file_glob), true, true)

    vim.list_extend(bundles, file_list)
  end, files)
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

  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}

return config
