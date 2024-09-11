{ lib, config, ... }:
let
	imvDesktop = [ "imv.desktop" ];
in 
{
	options.apps.gui.imv.enable = lib.mkEnableOption "Enable imv module";

	config = lib.mkIf config.apps.gui.imv.enable {
		programs.imv = {
			enable = true;

			settings = {
				options.overlay = true;
			};
		};

		xdg.mimeApps.defaultApplications = {
			"image/gif" = imvDesktop;
			"image/png" = imvDesktop;
			"image/apng" = imvDesktop;
			"image/avif" = imvDesktop;
			"image/jpeg" = imvDesktop;
			"image/webp" = imvDesktop;
			"image/svg+xml" = imvDesktop;
		};
	};
}
