local M = {}

function M.disable_line_num()
  local buftype = vim.bo.buftype

  if buftype ~= 'terminal' then
    return
  end

  vim.cmd [[setlocal nonumber]]
  vim.cmd [[setlocal norelativenumber]]
  vim.cmd [[setlocal signcolumn=no]]
end

return M
