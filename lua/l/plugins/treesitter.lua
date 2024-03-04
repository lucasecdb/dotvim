require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  indent = { enable = true },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- Classes
        ['ac'] = { query = '@class.outer', desc = 'Select outer part of class region' },
        ['ic'] = { query = '@class.inner', desc = 'Select inner part of class region' },

        -- Blocks
        ['ab'] = { query = '@block.outer' },
        ['ib'] = { query = '@block.inner' },

        -- Functions
        ['af'] = { query = '@function.outer', desc = 'Select outer part of function region' },
        ['if'] = { query = '@function.inner', desc = 'Select inner part of function region' },
        ['ap'] = { query = '@parameter.outer', desc = 'Select outer part of parameter list' },
        ['ip'] = { query = '@parameter.inner', desc = 'Select inner part of parameter list' },
      },

      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },

      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true or false
      include_surrounding_whitespace = true,
    },
    swap = {
      -- Enable swapping functionality
      enable = true,

      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
    move = {
      enable = true,

      set_jumps = true, -- Whether to set jumps in the jumplist

      goto_next_start = {
        [']m'] = { query = '@function.outer', desc = 'Next function start' },
        [']]'] = { query = '@class.outer', desc = 'Next class start' },
      },
      goto_previous_start = {
        ['[m'] = { query = '@function.outer', desc = 'Previous function start' },
        [']]'] = { query = '@class.outer', desc = 'Previous class start' },
      },
      goto_next_end = {
        [']M'] = { query = '@function.outer', desc = 'Next function end' },
        [']['] = { query = '@class.outer', desc = 'Next class end' },
      },
      goto_previous_end = {
        ['[M'] = { query = '@function.outer', desc = 'Previous function end' },
        ['[]'] = { query = '@class.outer', desc = 'Previous class end' },
      },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      floating_preview_opts = {},
      peek_definition_code = {
        ['<leader>df'] = { query = '@function.outer', desc = 'Peek [d]efinition for [f]unction' },
        ['<leader>dF'] = { query = '@function.outer', desc = 'Peek [d]efinition for class' },
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

local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

-- Repeat movement with ; and ,
-- vim way: ; goes to the direction you were moving.
vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)
