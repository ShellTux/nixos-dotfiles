local function colorscheme_exists(scheme)
	for _, valid_scheme in ipairs(vim.fn.getcompletion("", "color")) do
		if valid_scheme == scheme then
			return true
		end
	end
	return false
end

function apply_random_colorscheme(color_schemes)
	local existing_schemes = {}
	for _, scheme in ipairs(color_schemes) do
		if colorscheme_exists(scheme) then
			table.insert(existing_schemes, scheme)
		end
	end

	if #existing_schemes == 0 then
		vim.notify('No valid colorschemes found.', 'error')
		return
	end

	local random_index = math.random(1, #existing_schemes)
	local selected_scheme = existing_schemes[random_index]

	vim.notify('Applying colorscheme: ' .. selected_scheme, 'info')
	vim.cmd.colorscheme(selected_scheme)
end

vim.api.nvim_create_user_command(
	'RandomColorscheme',
	function(opts) apply_random_colorscheme(vim.g.favorite_colorschemes) end,
	{ nargs = 0 }
)

vim.cmd.RandomColorscheme()
