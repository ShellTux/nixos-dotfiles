local ToggleAutoSave = require('functions').ToggleAutoSave

vim.api.nvim_create_augroup('AutoSave', {})

vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
	group = 'AutoSave',
	pattern = { '*' },
	command = 'if exists("g:auto_save") && g:auto_save | silent write | endif',
})

vim.api.nvim_create_user_command('ToggleAutoSave', ToggleAutoSave, {})
