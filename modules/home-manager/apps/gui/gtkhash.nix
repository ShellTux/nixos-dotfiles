{ lib, config, pkgs, ... }:
{
	options.apps.gui.gtkhash.enable = lib.mkEnableOption "Enable gtkhash module";

	config = lib.mkIf config.apps.gui.gtkhash.enable {
		home.packages = with pkgs; [
			gtkhash
		];
	};
}
