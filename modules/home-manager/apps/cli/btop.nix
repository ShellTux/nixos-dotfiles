{ lib, config, ... }:
{
	options.apps.cli.btop.enable = lib.mkEnableOption "Enable btop module";

	config = lib.mkIf config.apps.cli.btop.enable {
		programs.btop = {
			enable = true;

			settings = {
				color_theme = "onedark";
				theme_background = true;
				update_ms = 200;
				proc_sorting = "cpu lazy";
			};
		};
	};
}
