{ lib, config, pkgs, ... }:
{
	options.apps.cli.unar.enable = lib.mkEnableOption "Enable unar module";

	config = lib.mkIf config.apps.cli.unar.enable {
		home.packages = with pkgs; [
			unar
		];
	};
}
