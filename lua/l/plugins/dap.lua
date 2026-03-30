local javascript_languages = { 'typescript', 'javascript' }

local icons = {
  Stopped = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
  Breakpoint = ' ',
  BreakpointCondition = ' ',
  BreakpointRejected = { ' ', 'DiagnosticError' },
  LogPoint = '.>',
}

local dap = require 'dap'
local dapui = require 'dapui'
local registry = require 'mason-registry'

vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

for name, sign in pairs(icons) do
  sign = type(sign) == 'table' and sign or { sign }
  vim.fn.sign_define(
    'Dap' .. name,
    { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] }
  )
end

-- Adapters
if registry.is_installed 'php-debug-adapter' then
  dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = {
      vim.fn.exepath 'php-debug-adapter',
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
  dap.adapters['pwa-node'] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
      command = 'node',
      args = { vim.fn.exepath 'js-debug-adapter', '${port}' },
    },
  }

  for _, language in ipairs(javascript_languages) do
    dap.configurations[language] = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = '(Vitest) Debug Current Test File',
        autoAttachChildProcesses = true,
        skipFiles = { '<node_internals>/**', '**/node_modules/**' },
        program = '${workspaceFolder}/node_modules/vitest/vitest.mjs',
        cwd = '${workspaceFolder}',
        args = { 'run', '${file}', '--test-timeout', '999999' },
        smartStep = true,
        console = 'neverOpen',
      },
      {
        type = 'pwa-node',
        request = 'attach',
        name = 'Attach',
        cwd = '${workspaceFolder}',
      },
    }
  end
end

-- DAP UI
dapui.setup()
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open {}
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close {}
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close {}
end

-- Keybindings
local function attach_with_launch_json()
  local path = vim.fn.expand '%'

  if path == nil or path == '' then
    path = vim.fn.getcwd()
  end

  local launch_json = vim.fs.find({
    '.vscode/launch.json',
  }, { upward = true, path = vim.fs.dirname(path) })[1]

  if vim.fn.filereadable(launch_json) then
    local dap_vscode = require 'dap.ext.vscode'
    dap_vscode.load_launchjs(launch_json, {
      ['pwa-node'] = javascript_languages,
    })
  end
  dap.continue()
end

-- stylua: ignore start
vim.keymap.set({ 'n', 'v' }, '<leader>d', '', { desc = '+debug' })
vim.keymap.set('n', '<leader>da', attach_with_launch_json, { desc = 'Attach' })
vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, { desc = 'Breakpoint Condition' })
vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = 'Toggle Breakpoint' })
vim.keymap.set('n', '<leader>dc', function() dap.continue() end, { desc = 'Continue' })
vim.keymap.set('n', '<leader>dC', function() dap.run_to_cursor() end, { desc = 'Run to Cursor' })
vim.keymap.set('n', '<leader>dg', function() dap.goto_() end, { desc = 'Go to Line (No Execute)' })
vim.keymap.set('n', '<leader>di', function() dap.step_into() end, { desc = 'Step Into' })
vim.keymap.set('n', '<leader>dj', function() dap.down() end, { desc = 'Down' })
vim.keymap.set('n', '<leader>dk', function() dap.up() end, { desc = 'Up' })
vim.keymap.set('n', '<leader>dl', function() dap.run_last() end, { desc = 'Run Last' })
vim.keymap.set('n', '<leader>do', function() dap.step_over() end, { desc = 'Step Over' })
vim.keymap.set('n', '<leader>dO', function() dap.step_out() end, { desc = 'Step Out' })
vim.keymap.set('n', '<leader>dp', function() dap.pause() end, { desc = 'Pause' })
vim.keymap.set('n', '<leader>dr', function() dap.repl.toggle() end, { desc = 'Toggle REPL' })
vim.keymap.set('n', '<leader>ds', function() dap.session() end, { desc = 'Session' })
vim.keymap.set('n', '<leader>dt', function() dap.terminate() end, { desc = 'Terminate' })
vim.keymap.set('n', '<leader>dw', function() require('dap.ui.widgets').hover() end, { desc = 'Widgets' })
vim.keymap.set('n', '<leader>du', function() dapui.toggle({}) end, { desc = 'Dap UI' })
vim.keymap.set({ 'n', 'v' }, '<leader>de', function() dapui.eval() end, { desc = 'Eval' })
-- stylua: ignore end
