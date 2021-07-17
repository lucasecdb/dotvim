local fn = vim.fn
local cmd = vim.cmd

-- Automatically install packer.nvim
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  local use = require('packer').use

  -- Packer can manage itself
  use { 'wbthomason/packer.nvim', opt = true }

  -- Base plugins
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use { 'junegunn/fzf', run = ':call fzf#install()' }
  use 'junegunn/fzf.vim'
  use 'jiangmiao/auto-pairs'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use 'folke/which-key.nvim'
  use 'kevinhwang91/nvim-bqf'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'ray-x/lsp_signature.nvim'
  use 'kabouzeid/nvim-lspinstall'
  use 'glepnir/lspsaga.nvim'

  -- Completion
  use 'hrsh7th/nvim-compe'
  use 'hrsh7th/vim-vsnip'

  -- Languages
  use 'udalov/kotlin-vim'
  use 'kchmck/vim-coffee-script'

  -- Colorschemes
  use 'lucasecdb/vim-codedark'
  use 'mhartington/oceanic-next'

  -- Copy from anywhere
  use 'ojroques/vim-oscyank'
end)
