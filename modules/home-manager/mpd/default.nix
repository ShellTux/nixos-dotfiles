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

		systemd.user.services.mpd-notification = {
			Unit = {
				Description = "MPD Notification";
				Requires = "dbus.socket";
				PartOf = "graphical-session.target";
				# Do not require any service here! We do rely on mpd OR network (for
				# a remote mpd instance). So let the user care.
				# We want to order after, though. This makes sure the resource is
				# available on start and mpd-notification can cleanly disconnect on
				# system shutdown.
				After = "mpd.service network.target network-online.target";
				# Order after notification daemons to make sure it is stopped before.
				# After = "dunst.service xfce4-notifyd.service";
				ConditionUser = "!@system";
			};

			Service = {
				Type = "notify";
				Restart = "on-failure";
				ExecStart = "${./mpd-notification.sh}";
			};

			Install.WantedBy = ["default.target"];
		};
	};
}
