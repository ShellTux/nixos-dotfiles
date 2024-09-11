{ lib, config, pkgs, ... }:
{
	options.apps.cli.mediainfo = {
		enable = lib.mkEnableOption "Enable mediainfo module";

		gui.enable = lib.mkEnableOption "Enable mediainfo GUI.";
	};

	config = lib.mkIf config.apps.cli.mediainfo.enable {
		home.packages = with pkgs; [
			mediainfo
			(lib.mkIf config.apps.cli.mediainfo.gui.enable mediainfo-gui)
		];
	};
}
