{ lib, config, ... }:
{
	options.apps.gui.wezterm.enable = lib.mkEnableOption "Enable wezterm module";

	config = lib.mkIf config.apps.gui.wezterm.enable {
		programs.wezterm = {
			enable = true;

			extraConfig = lib.fileContents ./wezterm.lua;
		};
	};
}
