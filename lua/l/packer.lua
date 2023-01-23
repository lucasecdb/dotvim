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
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'feline-nvim/feline.nvim'
    use 'folke/which-key.nvim'
    use 'kevinhwang91/nvim-bqf'

    -- Fuzzy finder
    use {'junegunn/fzf', run = ':call fzf#install()'}
    use 'junegunn/fzf.vim'
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'ray-x/lsp_signature.nvim'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    -- Completion
    use 'hrsh7th/nvim-compe'
    use 'hrsh7th/vim-vsnip'

    -- Languages
    use 'udalov/kotlin-vim'
    use 'kchmck/vim-coffee-script'

    -- Colorschemes
    use 'lucasecdb/vim-codedark'
    use 'mhartington/oceanic-next'
    use 'shaunsingh/nord.nvim'
    use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        requires = {"kyazdani42/nvim-web-devicons"}
    })

    -- Copy from anywhere
    use 'ojroques/vim-oscyank'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then require('packer').sync() end
end)
