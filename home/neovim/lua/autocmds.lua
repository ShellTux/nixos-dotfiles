vim.api.nvim_create_autocmd('BufWritePost', {
	pattern = '*.service',
	callback = function()
		vim.fn.system('systemctl --user daemon-reload')
	end,
})
