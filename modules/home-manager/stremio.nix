{ lib, config, pkgs, ... }:
{
	options.stremio.enable = lib.mkEnableOption "Enable stremio module";

	config = lib.mkIf config.stremio.enable {
		home.packages = with pkgs; [
			stremio
		];
	};
}
