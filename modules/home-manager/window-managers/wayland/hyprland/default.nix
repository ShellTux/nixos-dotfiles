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

    settings = import ./settings/default.nix { inherit pkgs; };

    brightnessScript = pkgs.pkgs.writeShellScriptBin "brightness" ''

    get_brightness() {
	    brightnessctl | awk '/Current brightness/ {print $4}' | sed 's/[()%]//g'
		    return
    }

set_brightness() {
	case $2 in
		+) brightnessctl set "+$1%" --quiet ;;
	-) brightnessctl set "$1%-" --min-value 1 --quiet ;;
	"") brightnessctl set "$1%" --min-value 1 --quiet ;;
	esac
}

if [ $# -eq 0 ]
then
printf 'Brightness: %d%%\n' "$(get_brightness)"
else
case "$1$2" in
notify) ;;
[0-9][+-]) set_brightness "$1" "$2" ;;
[0-9]) set_brightness "$1" ;;
*) usage ;;
esac
fi

    appName="$(basename "$0")"
    msgTag='brightness'
    brightness="$(get_brightness)"
    brightness_level="$(echo "$brightness" | awk '{ print sprintf("%.0f", $1/100*4) }')"
    case "$brightness_level" in
    0) icon='brightness-low' ;;
    1) icon='brightness-medium' ;;
    2) icon='brightness-medium' ;;
    3) icon='brightness-high' ;;
    4) icon='brightness-high' ;;
    esac
    notify-send --app-name="$appName" \
			    --urgency=low \
			    --icon="$icon" \
			    --hint=string:x-dunst-stack-tag:"$msgTag" \
			    --hint=int:value:"$brightness" "Brightness: $${brightness}%"
    '';
in
{
	imports = let path = ../../..; in [
		(path + "/waybar/default.nix")
	];

	options = {
		hyprland.enable = lib.mkEnableOption "Enable hyprland module";
		# TODO: Enable swww
	};

	config = lib.mkIf config.hyprland.enable {
		waybar.enable = true;

		wayland.windowManager.hyprland =  {
			enable = true;

			systemd.enable = true;
			xwayland.enable = true;

			settings = settings;
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

			dunst = {
				enable = true;
			};

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
		];
	};
}
