local prettier = {
  formatCommand = "prettier",
}

local eslint = {
  lintCommand = 'eslint -f visualstudio --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    '%f(%l,%c): %tarning %m',
    '%f(%l,%c): %rror %m',
  },
}

local luaformat = {
  formatCommand = "lua-format -i",
  formatStdin = true
}

return {
  filetypes = {
    "lua",
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  init_options = {
    documentFormatting = true
  },
  settings = {
    rootMarkers = { ".git/" },
    languages = {
      lua = { luaformat },
      javascript = { eslint, prettier },
      javascriptreact = { eslint, prettier },
      ['javascript.jsx'] = { eslint, prettier },
      typescript = { eslint, prettier },
      typescriptreact = { eslint, prettier },
      ['typescript.tsx'] = { eslint, prettier },
    },
  }
}
