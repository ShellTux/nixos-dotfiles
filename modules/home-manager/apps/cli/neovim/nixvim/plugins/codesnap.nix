{ config, ... }:
{
	programs.nixvim.plugins.codesnap.settings = {
		breadcrumbs_separator = "/";
		has_breadcrumbs = true;
		has_line_number = false;
		mac_window_bar = true;
		save_path = config.xdg.userDirs.pictures;
		title = "CodeSnap.nvim";
		watermark = "";
	};
}
