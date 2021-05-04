local fn = vim.fn
local cmd = vim.cmd

-- Automatically install packer.nvim
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use { 'wbthomason/packer.nvim', opt = true }

  use { 'neoclide/coc.nvim', run = 'yarn install --frozen-lockfile' }
  use 'neoclide/jsonc.vim'
  use 'tpope/vim-surround'
  use { 'junegunn/fzf', run = ':call fzf#install()' }
  use 'junegunn/fzf.vim'
  use 'tpope/vim-fugitive'
  use 'jiangmiao/auto-pairs'
  use 'lucasecdb/vim-codedark'
  use 'vim-airline/vim-airline'
  use 'udalov/kotlin-vim'
  use 'vim-airline/vim-airline-themes'
  use 'jparise/vim-graphql'
  use { 'Shougo/deoplete.nvim', run = ':UpdateRemotePlugins' }
  use 'rust-lang/rust.vim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Javascript
  use 'pangloss/vim-javascript'
  use 'mxw/vim-jsx'
  use 'leafgarland/typescript-vim'
  use 'MaxMEllon/vim-jsx-pretty'

  -- Coffeescript
  use 'kchmck/vim-coffee-script'
end)
