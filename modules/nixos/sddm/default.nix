{ lib, config, ... }:
{
	options.sddm = {
		enable = lib.mkEnableOption "Enable sddm module";
	};

	config = lib.mkIf config.sddm.enable {
		services.displayManager.sddm = {
			enable = true;

			autoNumlock = true;
			wayland.enable = true;

			settings.Theme = {
				EnableAvatars = true;
				DisableAvatarsThreshold = 7;
			};
		};
	};
}
