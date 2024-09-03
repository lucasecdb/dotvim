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
    },
  }
end
