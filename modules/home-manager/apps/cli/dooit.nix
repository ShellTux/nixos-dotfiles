{ lib, config, pkgs, ... }:
{
	options.apps.cli.dooit.enable = lib.mkEnableOption "Enable dooit module";

	config = lib.mkIf config.apps.cli.dooit.enable {
		home.packages = with pkgs; [
			dooit
		];
	};
}
