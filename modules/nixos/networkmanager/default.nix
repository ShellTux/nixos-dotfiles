{ lib, config, ...}:
{
	options = {
		networkmanager.enable = lib.mkEnableOption "Enable networkmanager module";
	};

	config = lib.mkIf config.networkmanager.enable {
		networking.networkmanager = {
			enable = true;

			# appendNameservers = [
			# 	"1.1.1.1"
			# 	"8.8.8.8"
			# 	"8.8.4.4"
			# ];
			wifi.powersave = true;
		};
	};
}
