{ lib, config, pkgs, ... }:
{
	options.jellyfin-media-player.enable = lib.mkEnableOption "Enable jellyfin-media-player module";

	config = lib.mkIf config.jellyfin-media-player.enable {
		home.packages = with pkgs; [
			jellyfin-media-player
		];
	};
}
