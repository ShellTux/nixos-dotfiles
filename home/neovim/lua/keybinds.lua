---------------
--- Keybindings
--------------
vim.g.mapleader = ' '
vim.keymap.set('n', 'cn', vim.cmd.cnext)
vim.keymap.set('n', 'cp', vim.cmd.cprevious)
vim.keymap.set('n', '<C-h>', vim.cmd.nohlsearch)
vim.keymap.set('n', '<C-j>', vim.cmd.bnext)
vim.keymap.set('n', '<C-k>', vim.cmd.bprevious)
vim.keymap.set('n', '<C-S-j>', '<cmd>tabmove -1<cr>')          -- Previous tab
vim.keymap.set('n', '<C-S-k>', '<cmd>tabmove +1<cr>')          -- Next tab
vim.keymap.set('n', '<C-Left>', vim.cmd.tabprevious)           -- Previous tab
vim.keymap.set('n', '<C-Right>', vim.cmd.tabnext)              -- Next tab
vim.keymap.set('n', '<leader>pv', vim.cmd.Explore)
vim.keymap.set('n', '<leader>tc', vim.cmd.tabclose)            -- Close tab
vim.keymap.set('n', '<Left>', '<cmd>vertical resize -2<cr>')   -- Vertical split resize
vim.keymap.set('n', '<Right>', '<cmd>vertical resize +2<cr>')  -- Vertical split resize
vim.keymap.set('n', '<up>', '<cmd>resize -2<cr>')              -- split resize
vim.keymap.set('n', '<down>', '<cmd>resize +2<cr>')            -- split resize
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true }) -- Escape Terminal
-- Reselect after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
-- https://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')
-- Visual move for wrapped text
vim.keymap.set('n', 'j', "(v:count == 0 ? 'gj' : 'j')", { silent = true, expr = true })
vim.keymap.set('n', 'k', "(v:count == 0 ? 'gk' : 'k')", { silent = true, expr = true })
-- Quick escape
vim.keymap.set('i', 'jj', '<Esc>')
