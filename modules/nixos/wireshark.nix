{ lib, config, pkgs, settings, ... }:
let
	username = settings.user.username;
in 
{
	options.wireshark.enable = lib.mkEnableOption "Enable wireshark module";

	config = lib.mkIf config.wireshark.enable {
		programs.wireshark = {
			enable = true;

			package = pkgs.wireshark;
		};

		users.users."${username}".extraGroups = [ "wireshark" ];
	};
}
