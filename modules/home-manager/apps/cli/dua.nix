{ lib, config, pkgs, ... }:
{
	options.apps.cli.dua.enable = lib.mkEnableOption "Enable dua module";

	config = lib.mkIf config.apps.cli.dua.enable {
		home.packages = with pkgs; [
			dua
		];
	};
}
