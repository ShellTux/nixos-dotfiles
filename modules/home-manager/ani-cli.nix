{ lib, config, pkgs, ... }:
{
	options.ani-cli.enable = lib.mkEnableOption "Enable ani-cli module";

	config = lib.mkIf config.ani-cli.enable {
		home.packages = with pkgs; [
			ani-cli
		];
	};
}
