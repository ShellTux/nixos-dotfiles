local has_telescope, _ = pcall(require, 'telescope')
local telescope_find_files
if has_telescope then
	telescope_find_files = require('telescope.builtin').find_files
end

local function findGitConflictFiles()
	local git_conflict_command = { 'git', 'diff', '--name-only', '--diff-filter', 'U' }
	if has_telescope then
		telescope_find_files({
			find_command = git_conflict_command,
			prompt_title = 'Git conflicts',
			attach_mappings = function(_, map)
				map("n", "<cr>", exec_dap)
				map("i", "<cr>", exec_dap)
				return true
			end,
		})
	else
		local handle = io.popen(table.concat(git_conflict_command, ' '))
		local result = handle:read("*a")
		handle:close()

		if result ~= '' then
			local command = string.format('echo "%s"',
			'Git conflict files found:\n' .. result)
			vim.api.nvim_command(command)
		else
			print('No git conflict files found.')
		end
	end
end

local function gitdiff(history, layout)
	return function()
		vim.cmd.tabnew('%')
		local command = 'Gvdiffsplit'

		if layout == 'horizontal' then
			command = 'Gdiffsplit'
		elseif layout == 'vertical' then
			command = 'Gvdiffsplit'
		end

		if history>= 0 then
			command = command .. ' HEAD~' .. history
		end
		vim.cmd(command)

		-- Setting sidescrolloff to maximum for both buffers
		for _ = 1, 2, 1 do
			vim.api.nvim_input('<C-w>w :setlocal sidescrolloff=999<cr>')
		end
	end
end

local function openCommandInNewTab(command)
	return function()
		vim.cmd.tabnew()
		vim.cmd(command)
		vim.api.nvim_input('<C-w>w:q<cr>')
		if (command ~= 'Git') then
			local current_buffer = vim.api.nvim_get_current_buf()
			vim.api.nvim_buf_set_name(current_buffer, command)
		end
	end
end

local function command(command_string)
	return function() vim.cmd(command_string) end
end

local module = {
	add      = command('Git add %'),
	checkout = command('Git checkout'),
	commit   = command('Git commit'),
	conflict = findGitConflictFiles,
	diff     = gitdiff,
	diff_staged = openCommandInNewTab('Git diff --staged'),
	git      = openCommandInNewTab('Git'),
	-- TODO: If more than 1 branch ask for which branch log
	graph    = openCommandInNewTab('Git log --graph'),
	-- TODO: If more than 1 branch ask for which branch log
	log      = openCommandInNewTab('Git log'),
	push     = command('Git push'),
	show     = openCommandInNewTab('Git show'),
	stage    = command('Git stage %'),
	switch   = command('Telescope git_branches'),
}

return module
