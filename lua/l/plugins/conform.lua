require('conform').setup {
  notify_on_error = false,
  format_on_save = {
    timeout_ms = 5000,
    lsp_fallback = true,
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    java = { 'ignore_format' },
    php = { 'php_cs_fixer' },
    gdscript = { 'gdformat' },
    graphql = { 'prettier' },
  },
  formatters = {
    ignore_format = {
      command = 'echo',
      stdin = true,
    },
    php_cs_fixer = {
      command = 'php-cs-fixer',
      stdin = false,
      args = { 'fix', '$FILENAME' },
      cwd = function(self, ctx)
        local get_root = require('conform.util').root_file { '.editorconfig', '.php-cs-fixer.dist.php' }

        return get_root(self, ctx)
      end,
      require_cwd = true,
    },
    gdformat = {
      command = 'gdformat',
      stdin = false,
      args = { '$FILENAME' },
    },
  },
}
