{ pkgs }:
let
	wallpaperScript = import ../wallpaper.nix { inherit pkgs; };

	decoration = import ./decoration.nix { };
	input = import ./input.nix { };
	bindm = import ./bindm.nix { };
	bind = import ./bind.nix { };
	windowrule = import ./windowrule.nix { };
in
{
	exec-once = [
		"${pkgs.firewalld-gui}/bin/firewall-applet"
		"${pkgs.qpwgraph}/bin/qpwgraph --minimized"
		"${pkgs.dunst}/bin/dunst"
		"${pkgs.networkmanagerapplet}/bin/nm-applet"
		"${pkgs.gammastep}/bin/gammastep-indicator"
	];
	exec = [
		''${wallpaperScript}/bin/wallpaperd daemon''
		''${pkgs.syncthingtray}/bin/syncthingtray --wait''
	];

	decoration = decoration;
	input = input;
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

	bindm = bindm;
	bind = bind;
	windowrule = windowrule;
}