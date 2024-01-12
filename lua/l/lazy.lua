local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- LuaFormatter off
require('lazy').setup({
    -- Base plugins
    {
        'kylechui/nvim-surround',
        version = '*',
        event = 'VeryLazy',
        config = function() require("l.plugins.surround") end
    },
    'tpope/vim-repeat',
    {
        'NeogitOrg/neogit',
        dependencies = {
          'nvim-lua/plenary.nvim',
          'sindrets/diffview.nvim',
          'nvim-telescope/telescope.nvim',
        },
        config = function() require('l.plugins.neogit') end
    },
    'jiangmiao/auto-pairs',
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        init = function()
          vim.o.timeout = true
          vim.o.timeoutlen = 300
        end,
        config = function() require('l.plugins.which-key') end
    },
    -- Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
        config = function() require('l.plugins.telescope') end
    },
    {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    -- UI
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = {'nvim-tree/nvim-web-devicons'}
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {'nvim-tree/nvim-web-devicons'},
        config = function() require('l.plugins.lualine') end
    },
    'kevinhwang91/nvim-bqf',
    {
      "utilyre/barbecue.nvim",
      name = "barbecue",
      version = "*",
      dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons",
      },
      config = function() require('l.plugins.barbecue') end
    },
    {'stevearc/oil.nvim', config = function() require('l.plugins.oil') end},

    -- LSP
    'neovim/nvim-lspconfig',
    'williamboman/mason-lspconfig.nvim',
    {
        'williamboman/mason.nvim',
        config = function() require('l.plugins.mason') end
    },

    -- Completion
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    {'hrsh7th/nvim-cmp', config = function() require('l.plugins.cmp') end},
    'hrsh7th/vim-vsnip', 'hrsh7th/vim-vsnip-integ',

    -- Languages
    'udalov/kotlin-vim',
    'kchmck/vim-coffee-script',

    -- Colorschemes
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function() require("l.plugins.treesitter") end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function() require('l.plugins.catppuccin') end
    },

    -- Copy from anywhere
    {'ojroques/nvim-osc52', config = function() require('l.plugins.osc52') end}
})
-- LuaFormatter on
