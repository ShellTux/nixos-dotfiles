{ lib, config, pkgs, ... }:
{
	options.dua.enable = lib.mkEnableOption "Enable dua module";

	config = lib.mkIf config.dua.enable {
		home.packages = with pkgs; [
			dua
		];
	};
}
