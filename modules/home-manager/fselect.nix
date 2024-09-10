{ lib, config, pkgs, ... }:
{
	options.fselect.enable = lib.mkEnableOption "Enable fselect module";

	config = lib.mkIf config.fselect.enable {
		home.packages = with pkgs; [
			fselect
		];
	};
}
