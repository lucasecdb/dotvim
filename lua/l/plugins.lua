local fn = vim.fn
local cmd = vim.cmd

-- Automatically install packer.nvim
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use { 'wbthomason/packer.nvim', opt = true }

  -- Base plugins
  use { 'neoclide/coc.nvim', branch = 'release' }
  use 'tpope/vim-surround'
  use { 'junegunn/fzf', run = ':call fzf#install()' }
  use 'junegunn/fzf.vim'
  use 'tpope/vim-fugitive'
  use 'jiangmiao/auto-pairs'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- Languages
  use 'udalov/kotlin-vim'
  use 'kchmck/vim-coffee-script'

  -- Colorschemes
  use 'lucasecdb/vim-codedark'
  use 'marko-cerovac/material.nvim'
end)
