{ lib, config, pkgs, ...}:
let
	dispatcherScripts = import ./dispatcher-scripts/default.nix { inherit pkgs; };
in
{
	options = {
		networkmanager.enable = lib.mkEnableOption "Enable networkmanager module";
	};

	config = lib.mkIf config.networkmanager.enable {
		networking.networkmanager = {
			enable = true;
			inherit dispatcherScripts;

			# appendNameservers = [
			# 	"1.1.1.1"
			# 	"8.8.8.8"
			# 	"8.8.4.4"
			# ];
			wifi.powersave = true;
		};
	};
}
