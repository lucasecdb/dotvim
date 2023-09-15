-- Automatically install packer.nvim
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') ..
                             '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            'git', 'clone', '--depth', '1',
            'https://github.com/wbthomason/packer.nvim', install_path
        })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function()
    local use = require('packer').use

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Base plugins
    use 'kylechui/nvim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-fugitive'
    use 'jiangmiao/auto-pairs'
    use 'folke/which-key.nvim'

    -- Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use {'nvim-telescope/telescope-file-browser.nvim'}

    -- UI
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'nvim-tree/nvim-web-devicons'
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'nvim-tree/nvim-web-devicons', opt = true}
    }
    use 'kevinhwang91/nvim-bqf'
    use {
        'utilyre/barbecue.nvim',
        tag = "*",
        requires = {"SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons"}
    }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'ray-x/lsp_signature.nvim'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    -- Completion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'

    -- Languages
    use 'udalov/kotlin-vim'
    use 'kchmck/vim-coffee-script'

    -- Colorschemes
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        requires = {"kyazdani42/nvim-web-devicons"}
    })

    -- Copy from anywhere
    use {'ojroques/nvim-osc52'}

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then require('packer').sync() end
end)
