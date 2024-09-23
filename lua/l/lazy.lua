local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  -- Base plugins
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require 'l.plugins.surround'
    end,
  },
  'tpope/vim-repeat',
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    config = function()
      require 'l.plugins.neogit'
    end,
  },
  'jiangmiao/auto-pairs',
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require 'l.plugins.which-key'
    end,
  },
  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    config = function()
      require 'l.plugins.telescope'
    end,
  },
  -- UI
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require 'l.plugins.lualine'
    end,
  },
  'kevinhwang91/nvim-bqf',
  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require 'l.plugins.barbecue'
    end,
  },
  {
    'stevearc/oil.nvim',
    config = function()
      require 'l.plugins.oil'
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
      },
      'williamboman/mason-lspconfig.nvim',

      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      require 'l.plugins.lsp'
    end,
  },

  -- DAP
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      {
        'mfussenegger/nvim-dap',
        config = function()
          require 'l.plugins.dap'
        end,
        -- stylua: ignore
        keys = {
          { "<leader>d", "", desc = "+debug", mode = {"n", "v"} },
          { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
          { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
          { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
          { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
          { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
          { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
          { "<leader>dj", function() require("dap").down() end, desc = "Down" },
          { "<leader>dk", function() require("dap").up() end, desc = "Up" },
          { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
          { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
          { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
          { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
          { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
          { "<leader>ds", function() require("dap").session() end, desc = "Session" },
          { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
          { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
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
  {
    'mfussenegger/nvim-jdtls',
    config = function()
      require 'jdtls'
    end,
  },

  -- Autoformat
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 5000,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        java = { 'ignore_format' },
        php = { 'php_cs_fixer' },
      },
      formatters = {
        ignore_format = {
          command = 'echo',
          stdin = true,
        },
        php_cs_fixer = {
          command = 'php-cs-fixer',
          stdin = false,
          args = { 'fix', '$FILENAME' },
          cwd = function(self, ctx)
            local get_root = require('conform.util').root_file { '.editorconfig', '.php-cs-fixer.dist.php' }

            return get_root(self, ctx)
          end,
          require_cwd = true,
        },
      },
    },
  },

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      require 'l.plugins.cmp'
    end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require 'l.plugins.treesitter'
    end,
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
    },
  },

  -- Colorschemes
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require 'l.plugins.catppuccin'
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  -- Copy from anywhere
  {
    'ojroques/nvim-osc52',
    config = function()
      require 'l.plugins.osc52'
    end,
  },
}
