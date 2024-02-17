local cmp = require 'cmp'

cmp.setup({
    snippet = {expand = function(args) vim.fn['vsnip#anonymous'](args.body) end},
    window = {},
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<c-y>'] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        {name = 'nvim_lsp'}, {name = 'vsnip'}, {name = 'buffer'}
    })
})
