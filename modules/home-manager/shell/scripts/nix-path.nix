{ pkgs }:
pkgs.writeShellApplication {
	name = "nix-path";

	runtimeInputs = with pkgs; [
		coreutils
		eza
		nix
	];

	text = builtins.readFile ./nix-path.sh;
}
