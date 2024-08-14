{ pkgs }:
pkgs.writeShellApplication {
	name = "volume";

	runtimeInputs = with pkgs; [
		coreutils
		gawk
		gnugrep
		libnotify
		pulsemixer
		wireplumber
	];
	text = builtins.readFile ./volume.sh;
}
