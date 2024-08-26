{ lib, config, pkgs, ... }:
{
	options.mpd = {
		enable = lib.mkEnableOption "Enable mpd module";

		install = {
			mpc = lib.mkOption {
				description = "Whether to install the mpc cli.";
				type = lib.types.bool;
				default = true;
			};
		};
	};

	config = lib.mkIf config.mpd.enable {
		services.mpd = {
			enable = true;

			network.startWhenNeeded = true;

			extraConfig = builtins.readFile ./extraConfig.conf;
			playlistDirectory = "${config.services.mpd.musicDirectory}/.mpd_playlists";
		};

		home.packages = with pkgs; [
			(lib.mkIf config.mpd.install.mpc mpc-cli)
		];
	};
}
