local M = {}

function M.opt(name, value, scopes)
    scopes = scopes or {vim.o}
    value = value == nil and true or value

    if type(value) == 'table' then value = table.concat(value, ',') end

    for _, scope in pairs(scopes) do scope[name] = value end
end

function M.t(str) return vim.api.nvim_replace_termcodes(str, true, true, true) end

function M.check_back_space()
    local col = vim.fn.col('.') - 1

    return col <= 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

return M
