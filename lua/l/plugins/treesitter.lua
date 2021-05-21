local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.embedded_templates = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
    files = {"src/parser.c"}
  },
  filetype = "ejs",
  used_by = {"erb"},
}

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  },
  playground = {
    enable = false,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
  ensure_installed = {
    'query', 'typescript', 'javascript', 'tsx', 'json', 'rust', 'graphql', 'python',
    'jsdoc', 'lua', 'css', 'bash', 'html', 'yaml', 'jsonc', 'scss', 'toml', 'dockerfile',
    'embedded_templates', 'elixir',
  },
}
