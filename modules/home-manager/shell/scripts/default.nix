{ pkgs, ... }:
{
	home.packages = [
		(import ./nix-path.nix { inherit pkgs; })
	];
}
