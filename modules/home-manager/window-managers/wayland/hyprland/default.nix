{ pkgs, lib, config, ... }:
let
    gammastep = {
    	coordinates = {
    		latitude = 38.0;
    		longitude = -9.0;
    	};

	temperature = {
		day = 5700;
		night = 3000;
	};
    };

    settings = import ./settings { inherit pkgs; };
in
{
	imports = [
		./pyprland
	];

	options = {
		hyprland.enable = lib.mkEnableOption "Enable hyprland module";
		# TODO: Enable swww
	};

	config = lib.mkIf config.hyprland.enable {
		pyprland.enable = true;

		wayland.windowManager.hyprland =  {
			enable = true;

			systemd.enable = true;
			xwayland.enable = true;

			inherit settings;

			extraConfig = ''
binds {
	workspace_back_and_forth = true
	allow_workspace_cycles = false
	focus_preferred_method = 0
}
			'';
		};

		programs.hyprlock = {
			enable = true;

			settings = {
				general = {
					disable_loading_bar = true;
					grace = 300;
					hide_cursor = true;
					no_fade_in = false;
				};

				background = [
				{
					path = "screenshot";
					blur_passes = 3;
					blur_size = 8;
				}
				];

				input-field = [
				{
					size = "200, 50";
					position = "0, -80";
					monitor = "";
					dots_center = true;
					fade_on_empty = false;
					font_color = "rgb(202, 211, 245)";
					inner_color = "rgb(91, 96, 120)";
					outer_color = "rgb(24, 25, 38)";
					outline_thickness = 5;
					placeholder_text = "Password...";
					shadow_passes = 2;
				}
				];
			};
		};

		services = {
			hypridle = {
				enable = true;

				settings = {
					general = {
						after_sleep_cmd = "hyprctl dispatch dpms on";
						ignore_dbus_inhibit = false;
						lock_cmd = "hyprlock";
					};

					listener = [
					{
						timeout = 900;
						on-timeout = "hyprlock";
					}
					{
						timeout = 1200;
						on-timeout = "hyprctl dispatch dpms off";
						on-resume = "hyprctl dispatch dpms on";
					}
					];
				};
			};

			dunst.enable = true;

			gammastep = {
				enable = true;

				latitude = gammastep.coordinates.latitude;
				longitude = gammastep.coordinates.longitude;
				provider = "manual";
				temperature = gammastep.temperature;
			};
		};

		# TODO: Fix derivation error with firefox
		home.packages = with pkgs; [
			dunst
			# firefox
			firewalld-gui
			hyprpaper
			kitty
			libnotify
			mpvpaper
			networkmanagerapplet
			pavucontrol
			pw-volume
			pwvucontrol
			qpwgraph
			swww
			syncthing
			wofi

			(import ../../brightness.nix { inherit pkgs; })
			(import ../../volume.nix { inherit pkgs; })
			(import ./wallpaper.nix { inherit pkgs; })
		];
	};
}
