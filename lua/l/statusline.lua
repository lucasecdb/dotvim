local g = vim.g
local cmd = vim.cmd

g.airline_powerline_fonts = 1
g.airline_theme = 'codedark'
g.airline_left_sep = ''
g.airline_right_sep = ''

cmd [[set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}]]
