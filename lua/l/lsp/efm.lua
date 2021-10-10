local prettier = {
    formatCommand = "prettier --stdin-filepath ${INPUT}",
    formatStdin = true
}

local eslint = {
    -- npm install -g eslint_d
    lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"}
}

local luaformat = {
    -- luarocks install --server=https://luarocks.org/dev luaformatter
    formatCommand = "lua-format -i",
    formatStdin = true
}

return {
    filetypes = {
        "lua", "javascript", "javascriptreact", "javascript.jsx", "typescript",
        "typescriptreact", "typescript.tsx"
    },
    init_options = {
        documentFormatting = true
    },
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {luaformat},
            javascript = {prettier, eslint},
            javascriptreact = {prettier, eslint},
            ['javascript.jsx'] = {prettier, eslint},
            typescript = {prettier, eslint},
            typescriptreact = {prettier, eslint},
            ['typescript.tsx'] = {prettier, eslint}
        }
    }
}
