{ lib, config, ... }:
{
	options = {
		wezterm.enable = lib.mkEnableOption "Enable wezterm module";
	};

	config = lib.mkIf config.wezterm.enable {
		programs.wezterm = {
			enable = true;

			extraConfig = lib.fileContents ./wezterm.lua;
		};
	};
}
