local dap = require 'dap'
local registry = require 'mason-registry'

if registry.is_installed 'php-debug-adapter' then
  dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = {
      vim.fs.joinpath(registry.get_package('php-debug-adapter'):get_install_path(), 'extension', 'out', 'phpDebug.js'),
    },
  }

  dap.configurations.php = {
    {
      type = 'php',
      request = 'launch',
      name = 'Listen for Xdebug',
      port = 9003,
      pathMappings = {
        ['/var/www/getyourguide.com/current'] = '${workspaceFolder}',
      },
    },
  }
end

if registry.is_installed 'js-debug-adapter' then
  local install_path = registry.get_package('js-debug-adapter'):get_install_path()

  dap.adapters['pwa-node'] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
      command = 'node',
      args = { install_path .. '/js-debug/src/dapDebugServer.js', '${port}' },
    },
  }

  local vitest_config = {
    type = 'pwa-node',
    request = 'launch',
    name = 'Debug Current Test File',
    autoAttachChildProcesses = true,
    skipFiles = { '<node_internals>/**', '**/node_modules/**' },
    program = '${workspaceFolder}/node_modules/vitest/vitest.mjs',
    cwd = '${workspaceFolder}',
    args = { 'run', '${file}' },
    smartStep = true,
    console = 'neverOpen',
  }

  dap.configurations.javascript = {
    vitest_config,
  }
  dap.configurations.typescript = {
    vitest_config,
  }
end
