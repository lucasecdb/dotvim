return {
  cmd = { 'godot-wsl-lsp' },
  handlers = {
    ['gdscript_client/changeWorkspace'] = function(err, result)
      if err then
        return
      end

      local windows_path = result['path']

      local handle = io.popen("wslpath '" .. windows_path .. "'")

      if handle == nil then
        return
      end

      local path = handle:read '*a'
      handle:close()

      vim.cmd.cd { args = { vim.trim(path) }, mods = { silent = true } }
    end,
  },
}
