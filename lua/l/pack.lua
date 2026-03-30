local pack_dir = vim.fn.stdpath 'data' .. '/site/pack/core/opt/'

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name ~= 'nvim-treesitter' then
      return
    end
    if ev.data.kind ~= 'install' and ev.data.kind ~= 'update' then
      return
    end
    if not ev.data.active then
      vim.cmd.packadd 'nvim-treesitter'
    end
    vim.cmd 'TSUpdate'
  end,
})

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name ~= 'telescope-fzf-native.nvim' then
      return
    end
    if ev.data.kind ~= 'install' and ev.data.kind ~= 'update' then
      return
    end
    if vim.fn.executable 'make' == 1 then
      vim.fn.system { 'make', '-C', pack_dir .. 'telescope-fzf-native.nvim' }
    end
  end,
})

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name ~= 'LuaSnip' then
      return
    end
    if ev.data.kind ~= 'install' and ev.data.kind ~= 'update' then
      return
    end
    if vim.fn.executable 'make' == 1 then
      vim.fn.system { 'make', 'install_jsregexp', '-C', pack_dir .. 'LuaSnip' }
    end
  end,
})

vim.pack.add {
  -- Colorscheme
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },

  -- Treesitter
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },

  -- Utils
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-lua/popup.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',

  -- Base plugins
  'https://github.com/kylechui/nvim-surround',
  'https://github.com/tpope/vim-repeat',
  'https://github.com/jiangmiao/auto-pairs',
  'https://github.com/echasnovski/mini.ai',
  'https://github.com/ojroques/nvim-osc52',

  -- Git
  'https://github.com/NeogitOrg/neogit',
  'https://github.com/sindrets/diffview.nvim',

  -- UI
  'https://github.com/folke/which-key.nvim',
  'https://github.com/akinsho/bufferline.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/kevinhwang91/nvim-bqf',
  'https://github.com/SmiteshP/nvim-navic',
  'https://github.com/utilyre/barbecue.nvim',
  'https://github.com/stevearc/oil.nvim',

  -- Telescope
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  { src = 'https://github.com/nvim-telescope/telescope.nvim', version = vim.version.range '0.2.x' },

  -- LSP
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/j-hui/fidget.nvim',

  -- DAP
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/mfussenegger/nvim-jdtls',

  -- Autoformat
  'https://github.com/stevearc/conform.nvim',

  -- Completion
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/hrsh7th/cmp-cmdline',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/saadparwaiz1/cmp_luasnip',

  -- Highlight TODO comments
  'https://github.com/folke/todo-comments.nvim',
}

-- Initialization
require 'l.plugins.catppuccin'
require 'l.plugins.treesitter'
require 'l.plugins.surround'
require 'l.plugins.mini-ai'
require 'l.plugins.osc52'
vim.o.timeout = true
vim.o.timeoutlen = 300
require 'l.plugins.which-key'
require 'l.plugins.lualine'
require 'l.plugins.barbecue'
require 'l.plugins.oil'
require('fidget').setup {}
require 'l.plugins.telescope'
require 'l.plugins.lsp'
require 'l.plugins.dap'
require 'l.plugins.conform'
require 'l.plugins.cmp'
require 'l.plugins.neogit'
require('todo-comments').setup { signs = false }
