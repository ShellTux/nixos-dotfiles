{ lib, config, pkgs, ... }:
let
	getPackage = flavor: 
		if flavor == "discord" then pkgs.discord
		else if flavor == "vesktop" then pkgs.vesktop
		else if flavor == "webcord" then pkgs.webcord
		else if flavor == "webcord-vencord" then pkgs.webcord-vencord
		else null;
in 
{
	options.apps.gui.discord = {
		enable = lib.mkEnableOption "Enable discord module";

		flavours = lib.mkOption {
			type = with lib.types; listOf (enum [
				"discord"
				"vesktop"
				"webcord"
				"webcord-vencord"
			]);
			default = [ "discord" ];
		};
	};

	config = lib.mkIf config.apps.gui.discord.enable {
		home.packages = lib.lists.forEach (config.apps.gui.discord.flavours) (getPackage);
	};
}
