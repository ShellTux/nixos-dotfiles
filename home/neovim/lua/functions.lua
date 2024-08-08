local function ToggleAutoSave()
	vim.g.auto_save = not vim.g.auto_save
	print('Auto-save is now ' .. (vim.g.auto_save and 'enabled' or 'disabled'))
end

return {
	ToggleAutoSave = ToggleAutoSave
}
