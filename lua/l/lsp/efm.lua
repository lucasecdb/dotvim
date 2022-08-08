local luaformat = {
    -- luarocks install --server=https://luarocks.org/dev luaformatter
    formatCommand = "lua-format -i",
    formatStdin = true
}

return {
    filetypes = {"lua"},
    init_options = {documentFormatting = true},
    settings = {rootMarkers = {".git/"}, languages = {lua = {luaformat}}}
}
