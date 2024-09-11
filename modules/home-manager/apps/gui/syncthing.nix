{ lib, config, ... }:
{
	options.apps.gui.syncthing.enable = lib.mkEnableOption "Enable syncthing module";

	config = lib.mkIf config.apps.gui.syncthing.enable {
		services.syncthing = {
			enable = true;

			tray.enable = true;
		};
	};
}
