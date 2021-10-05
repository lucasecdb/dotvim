local M = {}

function M.configure()
    local buftype = vim.bo.buftype

    if buftype ~= "terminal" then return end

    vim.cmd [[setlocal nonumber]]
    vim.cmd [[setlocal norelativenumber]]
    vim.cmd [[setlocal signcolumn=no]]
end

return M
