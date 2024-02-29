return {
    root_dir = function(fname)
        return vim.fs.dirname(vim.fs.find({
            'tsconfig.json', 'package.json', 'jsconfig.json', '.git'
        }, {upward = true, path = vim.fs.dirname(fname)})[1])
    end,
    handlers = {
        ['$/typescriptVersion'] = function(err, result)
            if err ~= nil then return end

            vim.b.lualine_ts_version = result.version
        end
    }
}
