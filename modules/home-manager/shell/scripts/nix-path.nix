{ pkgs }:
pkgs.writeShellApplication {
	name = "nix-path";

	runtimeInputs = with pkgs; [
		nix
		eza
	];

	text = builtins.readFile ./nix-path.sh;
}
