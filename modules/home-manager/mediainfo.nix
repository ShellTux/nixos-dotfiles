{ lib, config, pkgs, ... }:
{
	options.mediainfo = {
		enable = lib.mkEnableOption "Enable mediainfo module";

		gui.enable = lib.mkEnableOption "Enable mediainfo GUI.";
	};

	config = lib.mkIf config.mediainfo.enable {
		home.packages = with pkgs; [
			mediainfo
			(lib.mkIf config.mediainfo.gui.enable mediainfo-gui)
		];
	};
}
