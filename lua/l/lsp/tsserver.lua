return {
    handlers = {
        ['$/typescriptVersion'] = function(err, result)
            if err ~= nil then return end

            vim.g.lualine_ts_version = result.version
        end
    }
}
