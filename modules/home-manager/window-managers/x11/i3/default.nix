{ pkgs, lib, config, ... }:
let
	terminal = "${pkgs.kitty}/bin/kitty";
in 
{
	options.i3.enable = lib.mkEnableOption "Enable i3 module";

	config = lib.mkIf config.i3.enable {
		xsession.windowManager.i3 = {
			enable = true;
			package = pkgs.i3-gaps;

			config = rec {
				modifier = "Mod4";
				bars = [ ];

				window.border = 0;

				gaps = {
					inner = 15;
					outer = 5;
				};

				keybindings = lib.mkOptionDefault {
					# "XF86AudioMute" = "exec amixer set Master toggle";
					# "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
					# "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
					# "XF86MonBrightnessDown" = "exec brightnessctl set 4%-";
					# "XF86MonBrightnessUp" = "exec brightnessctl set 4%+";
					"${modifier}+Return" = "exec ${terminal}";
					"${modifier}+p" = "exec ${pkgs.rofi}/bin/rofi -modi drun -show drun";
					"${modifier}+Shift+p" = "exec ${pkgs.rofi}/bin/rofi -show window";
				};

				startup = [
				{
					command = "exec i3-msg workspace 1";
					always = true;
					notification = false;
				}
				{
					command = "systemctl --user restart polybar.service";
					always = true;
					notification = false;
				}
				{
					command = "${pkgs.feh}/bin/feh --bg-scale ~/background.png";
					always = true;
					notification = false;
				}
				];
			};
		};
	};
}