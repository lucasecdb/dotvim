local dap = require 'dap'

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = {
    vim.fs.joinpath(vim.fn.stdpath 'data' --[[@as string]], 'mason', 'packages', 'php-debug-adapter', 'extension', 'out', 'phpDebug.js'),
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
