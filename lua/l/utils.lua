local set_opt = vim.api.nvim_set_option
local M = {}

function M.opt(name, value, scopes)
  scopes = scopes or {vim.o}
  value = value == nil and true or value

  if type(value) == 'table' then
    value = table.concat(value, ',')
  end

  for _, scope in pairs(scopes) do
    scope[name] = value
  end
end

function M.map(modes, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == 'string' then modes = {modes} end
  for _, mode in ipairs(modes) do vim.api.nvim_set_keymap(mode, lhs, rhs, opts) end
end

return M
