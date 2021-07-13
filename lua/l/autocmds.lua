require('l.utils').create_augroups {
  terminal = {
    {'TermOpen', '*', [[lua require('l.terminal.functions').configure()]]},
    {'WinEnter', '*', [[lua require('l.terminal.functions').configure()]]},
    {'WinLeave', '*', [[lua require('l.terminal.functions').configure()]]},
    {'BufEnter', '*', [[lua require('l.terminal.functions').configure()]]},
    {'BufLeave', '*', [[lua require('l.terminal.functions').configure()]]},
  },
  yank = {
    {'TextYankPost', '*', [[if v:event.operator is 'y' && v:event.regname is '' | OSCYankReg " | endif]]},
  },
}
