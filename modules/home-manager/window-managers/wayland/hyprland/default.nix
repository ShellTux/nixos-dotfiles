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

    startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
      ${pkgs.firewalld-gui}/bin/firewall-applet &
      ${pkgs.qpwgraph}/bin/qpwgraph --minimized &
      ${pkgs.dunst}/bin/dunst &
      ${pkgs.networkmanagerapplet}/bin/nm-applet &
      ${pkgs.gammastep}/bin/gammastep-indicator &
  
      sleep 1
    '';

    wallpaperScript = ./wallpaper.sh;

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
		(path + "/waybar.nix")
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

			settings = {
				exec-once = ''${startupScript}/bin/start'';
				exec = [
					''${pkgs.swww}/bin/swww-daemon --format xrgb''
					''${wallpaperScript} daemon''
				];

			decoration = {
				shadow_offset = "0 5";
				blur = {
					enabled = "yes";
					new_optimizations = "on";
					passes = 1;
					size = 3;
				};
				"col.shadow" = "rgba(1a1a1aee)";
				drop_shadow = "yes";
					active_opacity = 1.0;
					inactive_opacity = 0.6;
					fullscreen_opacity = 1.0;
					rounding = 10;
					shadow_range = 4;
					shadow_render_power = 3;
				};

				input = {
					kb_layout = "pt";

					follow_mouse = 1;

					touchpad = {
						natural_scroll = "no";
						disable_while_typing = true;
					};

					sensitivity = 0;
					numlock_by_default = true;
				};

				gestures = {
					workspace_swipe = "on";
					workspace_swipe_fingers = 3;
				};

				general = {
					border_size = 3;
					"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
					"col.inactive_border" = "rgba(595959aa)";
					gaps_in = 5;
					gaps_out = 20;
					layout = "master";
				};

				misc = {
					enable_swallow = true;
					swallow_regex = "^(Alacritty|kitty|St)$";
					# HACK: swallow_exception_regex only works assuming parent window to be
					# swallowed changed to the title of swallower window
					# This can be achieved by defining a function in your shell `preexec` (zsh
					# only).
					# You can look up preexec for bash: https://github.com/rcaloras/bash-preexec
					swallow_exception_regex = "^(wev|ueberzugpp_.*|ranger)$";
				};

				binds = {
					workspace_back_and_forth = true;
					allow_workspace_cycles = false;
					focus_preferred_method = 0;
				};

				"$altMod" = "ALT";
				"$mainMod" = "SUPER";
				"$superAlt" = "SUPER ALT";
				"$superControlShift" = "SUPER CONTROL SHIFT";
				"$superShift" = "SUPER SHIFT";
				"$TERMINAL" = "kitty";
				"$BROWSER" = "firefox";
				"$SCRATCHPAD" = "kitty";

				bindm = [
					"$mainMod, mouse:272, movewindow"
					"$mainMod, mouse:273, resizewindow"
				];

				bind = [
					"$mainMod, Return, exec, $TERMINAL"
					"$mainMod, C, killactive, "
					"$mainMod, P, exec, wofi --allow-images --show drun"
					"$superShift, Q, exec, pkill waybar; hyprctl dispatch exit"

					"$mainMod, Space, togglefloating, "
					"$altMod, Tab, cyclenext, "
					"$mainMod, F, fullscreen, 0"

					"$mainMod, H, movefocus, l"
					"$mainMod, L, movefocus, r"
					"$mainMod, K, movefocus, u"
					"$mainMod, J, movefocus, d"

					# Switch workspaces with mainMod + [0-9]"
					"$mainMod, 1, workspace, 1"
					"$mainMod, 2, workspace, 2"
					"$mainMod, 3, workspace, 3"
					"$mainMod, 4, workspace, 4"
					"$mainMod, 5, workspace, 5"
					"$mainMod, 6, workspace, 6"
					"$mainMod, 7, workspace, 7"
					"$mainMod, 8, workspace, 8"
					"$mainMod, 9, workspace, 9"
					"$mainMod, 0, workspace, 10"
					"$mainMod, right, workspace, e+1"
					"$mainMod, left, workspace, e-1"
					"$mainMod, U, focusurgentorlast"
					"$mainMod, TAB, focusurgentorlast"


					# Move active window to a workspace with mainMod + SHIFT + [0-9]
					"$superShift, 1, movetoworkspace, 1"
					"$superShift, 2, movetoworkspace, 2"
					"$superShift, 3, movetoworkspace, 3"
					"$superShift, 4, movetoworkspace, 4"
					"$superShift, 5, movetoworkspace, 5"
					"$superShift, 6, movetoworkspace, 6"
					"$superShift, 7, movetoworkspace, 7"
					"$superShift, 8, movetoworkspace, 8"
					"$superShift, 9, movetoworkspace, 9"
					"$superShift, 0, movetoworkspace, 10"
					"$superControlShift, right, movetoworkspace, e+1"
					"$superControlShift, left, movetoworkspace, e-1"
					# SUPER, Tab, movetoworkspace, previous

					# Turn off main monitor
					# FIX: https://github.com/hyprwm/Hyprland/issues/2845
					"$super, backslash, exec, sleep .4 && [ \"$(hyprctl monitors -j | jq '.[]|select(.name==\"eDP-1\").dpmsStatus')\" = true ] && hyprctl dispatch dpms off eDP-1 || hyprctl dispatch dpms on eDP-1"

					# Volume
					", XF86AudioRaiseVolume, exec, volume 5 +"
					", XF86AudioLowerVolume, exec, volume 5 -"
					"SHIFT, XF86AudioRaiseVolume, exec, volume 1 +"
					"SHIFT, XF86AudioLowerVolume, exec, volume 1 -"
					", XF86AudioMute, exec, volume toggle-mute"

					# Brightness
					",XF86MonBrightnessUp,    exec, ${brightnessScript}/bin/brightness 5 +"
					",XF86MonBrightnessDown,  exec, ${brightnessScript}/bin/brightness 5 -"
				];

				windowrule = [
					"center, floating:1, .*"
					"animation none,Rofi"
					"float, confirm"
					"float, confirmreset"
					"float, dialog"
					"float, download"
					"float, error"
					"float, feh"
					"float, file_progress"
					"float, file-roller"
					"float, gcolor3"
					"float, Lxappearance"
					"float, nm-connection-editor"
					"float, notification"
					"float, org.kde.polkit-kde-authentication-agent-1 "
					"float, pavucontrol"
					"float, pavucontrol-qt"
					"float, qt5ct"
					"float, Rofi"
					"float, Scratchpad"
					"float, splash"
					"float, syncthing-gtk"
					"float, syncthingtray"
					"float, title:branchdialog"
					"float, title:Confirm to replace files"
					"float, title:^/dev/ttyUSB"
					"float, title:File Operation Progress"
					"float, title:^(Media viewer)$"
					"float, title:Open File"
					"float, title:^(Picture-in-Picture)$"
					"float, title:^(Vídeo em janela flutuante)$"
					"float, title:^(Volume Control)$"
					"float, title:wlogout"
					"float, viewnior"
					"float, Viewnior"
					"noborder, ^wofi$"
					"opaque, title:^(Vídeo em janela flutuante)$"
					"fullscreen, title:wlogout"
					"fullscreen, wlogout"
					"idleinhibit focus, com.stremio.stremio"
					"idleinhibit focus, Jellyfin Media Player"
					"idleinhibit focus, mpv"
					"idleinhibit focus, org.jellyfin.jellyfinmediaplayer"
					"idleinhibit fullscreen, firefox"
					"idleinhibit fullscreen, firefox-developer-edition"
					"move 75 44%, title:^/dev/ttyUSB"
					"move 75 44%, title:^(Volume Control)$"
					"size 600 400, title:^(Volume Control)$"
					"size 800 600, title:^/dev/ttyUSB"
					"size 600 400, qt5ct"
					"workspace 5, one.alynx.showmethekey"
					"float, title:^(Floating Window - Show Me The Key)$"
					"size 781 113, title:^(Floating Window - Show Me The Key)$"
					"move 893 35, title:^(Floating Window - Show Me The Key)$"
					"workspace 1, title:^(Floating Window - Show Me The Key)$"
					"pin, title:^(Floating Window - Show Me The Key)$"
					"noanim, ^ueberzugpp_.*$"

					"workspace 1, Alacritty"
					"workspace 1, Arduino IDE"
					"workspace 2, firefox"
					"workspace 4, krita"
					"workspace 4, xournalpp"
					"workspace 5, org.keepassxc.KeePassXC"
					"workspace 7, com.obsproject.Studio"
					"workspace 7, com.stremio.stremio"
					"workspace 7, Jellyfin Media Player"
					"workspace 7, org.jellyfin.jellyfinmediaplayer"
					"workspace 8, com-atlauncher-App"
					"workspace 8, lutris"
					"workspace 8, Minecraft"
					"workspace 8, PPSSPPQt"
					"workspace 8, PPSSPPSDL"
					"workspace 8, rpcs3"
					"workspace 8, steam"
					"workspace 8, Steam"
					"workspace 8, SummertimeSaga # 😉"
					"workspace 9, discord"
					"workspace 9, WebCord"
					"workspace 9, zoom"
				];
			};
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
			wofi
		];
	};
}
