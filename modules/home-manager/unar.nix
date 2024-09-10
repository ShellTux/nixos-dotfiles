{ lib, config, pkgs, ... }:
{
	options.unar.enable = lib.mkEnableOption "Enable unar module";

	config = lib.mkIf config.unar.enable {
		home.packages = with pkgs; [
			unar
		];
	};
}
