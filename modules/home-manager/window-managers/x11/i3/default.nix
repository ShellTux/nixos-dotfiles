{ pkgs, lib, config, ... }:
let
	terminal = "${pkgs.kitty}/bin/kitty";
	brightnessScript = import ../../brightness.nix { inherit pkgs; };
	volumeScript = import ../../volume.nix { inherit pkgs; };
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
					# Volume
					"XF86AudioMute" = "exec ${volumeScript}/bin/volume toggle-mute";
					"XF86AudioLowerVolume" = "exec ${volumeScript}/bin/volume 5 -";
					"XF86AudioRaiseVolume" = "exec ${volumeScript}/bin/volume 5 +";

					# Music
					"XF86AudioPlay" = "exec ${pkgs.mpc-cli}/bin/mpc toggle";
					"XF86AudioPrev" = "exec ${pkgs.mpc-cli}/bin/mpc prev";
					"XF86AudioNext" = "exec ${pkgs.mpc-cli}/bin/mpc next";

					# Brightness
					"XF86MonBrightnessDown" = "exec ${brightnessScript}/bin/brightness 5 -";
					"XF86MonBrightnessUp" = "exec ${brightnessScript}/bin/brightness 5 +";

					"${modifier}+Return" = "exec ${terminal}";
					"${modifier}+p" = "exec ${pkgs.rofi}/bin/rofi -modi drun -show drun -show-icons";
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
