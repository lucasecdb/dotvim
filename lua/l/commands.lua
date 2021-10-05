local cmd = vim.cmd
local fn = vim.fn

cmd [[command! WQ wq]]
cmd [[command! Wq wq]]
cmd [[command! W w]]
cmd [[command! Q q]]

local fzf_path = fn.stdpath('data') .. '/site/pack/packer/start/fzf.vim'
local fzf_preview_sh = fzf_path .. '/bin/preview.sh'

cmd('command! -bang -nargs=? -complete=dir GFiles' ..
        "call fzf#vim#gitfiles(<q-args>, {'options': ['--preview', '" ..
        fzf_preview_sh .. " {}']})")
