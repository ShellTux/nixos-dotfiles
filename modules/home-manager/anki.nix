{ lib, config, pkgs, ... }:
{
	options.anki.enable = lib.mkEnableOption "Enable anki module";

	config = lib.mkIf config.anki.enable {
		home.packages = with pkgs; [
			anki
		];
	};
}
