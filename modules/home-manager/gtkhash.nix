{ lib, config, pkgs, ... }:
{
	options.gtkhash.enable = lib.mkEnableOption "Enable gtkhash module";

	config = lib.mkIf config.gtkhash.enable {
		home.packages = with pkgs; [
			gtkhash
		];
	};
}
