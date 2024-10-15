{ pkgs }:
pkgs.writeShellApplication {
	name = "fzfp";

	runtimeInputs = with pkgs; [
		bat
		fd
		fzf
	];

	text = builtins.readFile ./fzfp.sh;
}
