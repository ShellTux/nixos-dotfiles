{}:
{
	enable = true;

	keymaps = {
		"<leader>pb" = {
			action = "buffers";
			options.desc = "Telescope Buffers";
		};
		"<leader>pc" = {
			action = "colorscheme enable_preview=true";
			options.desc = "Telescope Colorschemes";
		};
		"<leader>pC" = {
			action = "git_branches";
			options.desc = "Telescope Git Branches";
		};
		"<leader>pf" = {
			action = "find_files";
			options.desc = "Telescope Find Files";
		};
		"<leader>pg" = {
			action = "git_files";
			options.desc = "Telescope Git Files";
		};
		"<leader>pG" = {
			action = "live_grep";
			options.desc = "Telescope Live Grep";
		};
		"<leader>ph" = {
			action = "help_tags";
			options.desc = "Telescope Help Tags";
		};
		"<leader>ps" = {
			action = "git_status";
			options.desc = "Telescope Git Status";
		};
		"<leader>pM" = {
			action = "man_pages sections=0p,1,2,3,3p,3type,7";
			options.desc = "Telescope Man Pages";
		};
	};
}
