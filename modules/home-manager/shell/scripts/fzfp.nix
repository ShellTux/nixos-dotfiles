{ pkgs }:
pkgs.writeShellApplication {
	name = "fzfp";

	runtimeInputs = with pkgs; [
		bat
		findutils
		fzf
	];

	text = builtins.readFile ./fzfp.sh;
}
