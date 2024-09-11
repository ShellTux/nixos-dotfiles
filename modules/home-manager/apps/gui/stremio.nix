{ lib, config, pkgs, ... }:
{
	options.apps.gui.stremio.enable = lib.mkEnableOption "Enable stremio module";

	config = lib.mkIf config.apps.gui.stremio.enable {
		home.packages = with pkgs; [
			stremio
		];
	};
}
