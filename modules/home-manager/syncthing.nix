{ lib, config, ... }:
{
	options = {
		syncthing.enable = lib.mkEnableOption "Enable syncthing module";
	};

	config = lib.mkIf config.syncthing.enable {
		services.syncthing = {
			enable = true;

			tray.enable = true;
		};
	};
}
