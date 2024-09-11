{ lib, config, ... }:
{
	options.apps.gui.zathura.enable = lib.mkEnableOption "Enable zathura module";

	config = lib.mkIf config.apps.gui.zathura.enable {
		programs.zathura = {
			enable = true;

			options = {
				guioptions = "sv";
				adjust-open = "width";
				recolor = true;
				selection-clipboard = "clipboard";
				window-title-basename = true;
				incremental-search = true;
			};

			mappings = {
				j = "navigate next";
				k = "navigate previous";
				"<S-j>" = "scroll down 10";
				"<S-k>" = "scroll up 10";
				h = "scroll down 10";
				l = "scroll up 10";
			};
		};
	};
}
