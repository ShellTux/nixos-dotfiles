{ pkgs }:
{
	format = "{volume}% {icon}";
	format-muted = "";
	on-click = "${pkgs.helvum}/bin/helvum";
	format-icons = [
		""
		""
		""
	];
}
