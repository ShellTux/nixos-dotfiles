{ lib, config, pkgs, ... }:
{
	options.qbittorrent.enable = lib.mkEnableOption "Enable qbittorrent module";

	config = lib.mkIf config.qbittorrent.enable {
		home.packages = with pkgs; [
			qbittorrent
		];
	};
}
