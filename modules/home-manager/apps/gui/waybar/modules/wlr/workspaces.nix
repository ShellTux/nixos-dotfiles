{ pkgs }:
{
	disable-scroll = true;
	all-outputs = true;
	active-only = false;
	format = "{name}: {icon}";
	format-icons = {
		"1" = "";
		"2" = "";
		"3" = "";
		"4" = "";
		"5" = "E";
		"6" = "";
		"7" = "";
		"8" = "";
		"9" = "";
		"urgent" = "";
		"focused" = "";
		"default" = "";
	};
	on-click = "activate";
	on-scroll-up = "${pkgs.hyprland}/bin/hyprctl dispatch workspace e-1";
	on-scroll-down = "${pkgs.hyprland}/bin/hyprctl dispatch workspace e+1";
}
