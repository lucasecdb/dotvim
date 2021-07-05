require('l.utils').create_augroups {
  -- coc = {
  --   {'CursorHold', '*', [[silent call CocActionAsync('highlight')]]}
  -- },
  terminal = {
    {'TermOpen', '*', [[lua require('l.terminal.functions').configure()]]},
    {'WinEnter', '*', [[lua require('l.terminal.functions').configure()]]},
    {'WinLeave', '*', [[lua require('l.terminal.functions').configure()]]},
    {'BufEnter', '*', [[lua require('l.terminal.functions').configure()]]},
    {'BufLeave', '*', [[lua require('l.terminal.functions').configure()]]},
  },
}
