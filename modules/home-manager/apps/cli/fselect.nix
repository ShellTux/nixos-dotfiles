{ lib, config, pkgs, ... }:
{
	options.apps.cli.fselect.enable = lib.mkEnableOption "Enable fselect module";

	config = lib.mkIf config.apps.cli.fselect.enable {
		home.packages = with pkgs; [
			fselect
		];
	};
}
