math.randomseed(os.time())
function random_colorscheme(filter_list)
	local colorschemes = vim.list_extend(vim.list_extend({}, vim.fn.getcompletion('', 'color')), vim.fn.getcompletion('*', 'color'))

	if filter_list then
		local filtered_schemes = {}
		for _, scheme in ipairs(colorschemes) do
			if vim.tbl_contains(filter_list, scheme) then
				table.insert(filtered_schemes, scheme)
			end
		end
		colorschemes = filtered_schemes
	end

	local chosen = colorschemes[math.random(#colorschemes)]
	vim.cmd('colorscheme ' .. chosen)
end

if vim.g.favorite_colorschemes then
	random_colorscheme(vim.g.favorite_colorschemes)
	vim.cmd('command! RandomColorscheme lua random_colorscheme(vim.g.favorite_colorschemes)')
else
	random_colorscheme()
	vim.cmd('command! RandomColorscheme lua random_colorscheme()')
end
--
--ApplyRandomColorscheme(favorite_colorschemes)
--
--function RandomColorscheme()
--	ApplyRandomColorscheme(favorite_colorschemes)
--end
--
--vim.cmd('command! RandomColorscheme lua RandomColorscheme()')
