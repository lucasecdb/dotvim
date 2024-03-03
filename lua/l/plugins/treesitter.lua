require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  indent = { enable = true },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['ac'] = '@comment.outer',
        ['ic'] = '@class.inner',
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
      },
    },
  },
  autotag = { enable = true },
  context_commentstring = { enable = true },
  ensure_installed = {
    'query',
    'typescript',
    'javascript',
    'tsx',
    'json',
    'lua',
    'bash',
    'vue',
  },
  auto_install = true,
}
