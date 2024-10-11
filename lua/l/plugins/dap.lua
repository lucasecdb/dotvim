local javascript_languages = { 'typescript', 'javascript' }

local icons = {
  Stopped = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
  Breakpoint = ' ',
  BreakpointCondition = ' ',
  BreakpointRejected = { ' ', 'DiagnosticError' },
  LogPoint = '.>',
}

local attach_with_launch_json = function()
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
  require('dap').continue()
end

return {
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      {
        'mfussenegger/nvim-dap',
        config = function()
          local dap = require 'dap'
          local registry = require 'mason-registry'

          vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

          for name, sign in pairs(icons) do
            sign = type(sign) == 'table' and sign or { sign }
            vim.fn.sign_define(
              'Dap' .. name,
              { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] }
            )
          end

          if registry.is_installed 'php-debug-adapter' then
            dap.adapters.php = {
              type = 'executable',
              command = 'node',
              args = {
                vim.fs.joinpath(
                  registry.get_package('php-debug-adapter'):get_install_path(),
                  'extension',
                  'out',
                  'phpDebug.js'
                ),
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
                args = { vim.fs.joinpath(install_path, 'js-debug', 'src', 'dapDebugServer.js'), '${port}' },
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
                  args = { 'run', '${file}' },
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
        end,
        -- stylua: ignore
        keys = {
          { '<leader>d', '', desc = '+debug', mode = { 'n', 'v' } },
          { '<leader>da', attach_with_launch_json, desc = 'Attach', },
          { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Breakpoint Condition', },
          { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint', },
          { '<leader>dc', function() require('dap').continue() end, desc = 'Continue', },
          { '<leader>dC', function() require('dap').run_to_cursor() end, desc = 'Run to Cursor', },
          { '<leader>dg', function() require('dap').goto_() end, desc = 'Go to Line (No Execute)', },
          { '<leader>di', function() require('dap').step_into() end, desc = 'Step Into', },
          { '<leader>dj', function() require('dap').down() end, desc = 'Down', },
          { '<leader>dk', function() require('dap').up() end, desc = 'Up', },
          { '<leader>dl', function() require('dap').run_last() end, desc = 'Run Last', },
          { '<leader>do', function() require('dap').step_over() end, desc = 'Step Over', },
          { '<leader>dO', function() require('dap').step_out() end, desc = 'Step Out', },
          { '<leader>dp', function() require('dap').pause() end, desc = 'Pause', },
          { '<leader>dr', function() require('dap').repl.toggle() end, desc = 'Toggle REPL', },
          { '<leader>ds', function() require('dap').session() end, desc = 'Session', },
          { '<leader>dt', function() require('dap').terminate() end, desc = 'Terminate', },
          { '<leader>dw', function() require('dap.ui.widgets').hover() end, desc = 'Widgets', },
        },
      },
      'nvim-neotest/nvim-nio',
    },
    opts = {},
    config = function(_, opts)
      local dap = require 'dap'
      local dapui = require 'dapui'
      dapui.setup(opts)
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open {}
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close {}
      end
    end,
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    },
  },
}
