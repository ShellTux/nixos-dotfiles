{ pkgs, lib, config, ... }:
{
	options.polkit.enable = lib.mkEnableOption "Enable polkit module";

	config = lib.mkIf config.polkit.enable {
		systemd.user.services.polkit-gnome-authentication-agent-1 = {
			Unit = {
				Description = "polkit-gnome-authentication-agent-1";
				After = [ "graphical-session.target" ];
				PartOf = [ "graphical-session.target" ];
				Wants = [ "graphical-session.target" ];
			};
			Service = {
				Type = "simple";
				ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
				Restart = "on-failure";
				RestartSec = 1;
				TimeoutStopSec = 10;
			};
			Install.WantedBy = [ "graphical-session.target" ];
		};

		wayland.windowManager.hyprland.settings.env =  let
			envVar = env: value: "${env}, ${value}";
		in [
			(envVar "GDK_BACKEND" "wayland,x11")
		];
	};
}
