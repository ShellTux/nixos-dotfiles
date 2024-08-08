vim.cmd('autocmd BufRead,BufNewFile *.txt set filetype=plaintext')
vim.cmd('autocmd FileType plaintext setlocal spell spelllang=pt_PT')
vim.cmd('highlight ColorColumn ctermbg=0 guibg=red')
vim.cmd('command! FilePath echo expand("%:p")')
