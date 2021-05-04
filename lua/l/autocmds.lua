--[[
function! CheckTermAndDisableNumber()
  if &buftype ==# "terminal"
    setlocal nonumber norelativenumber
  endif
endfunc

filetype indent plugin on

augroup Coc
  autocmd!
  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

augroup Term
  autocmd!
  autocmd TermOpen * :call CheckTermAndDisableNumber()
  autocmd WinLeave * :call CheckTermAndDisableNumber()
  autocmd WinEnter * :call CheckTermAndDisableNumber()
  autocmd BufEnter * :call CheckTermAndDisableNumber()
  autocmd BufLeave * :call CheckTermAndDisableNumber()
augroup END
--]]
