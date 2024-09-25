{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
	nativeBuildInputs = with pkgs; [
		git
		git-crypt
		gitleaks
		home-manager
		pre-commit
		sops
	];
}
