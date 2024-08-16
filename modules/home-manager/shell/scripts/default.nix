{ pkgs, ... }:
{
	home.packages = [
		(import ./nix-path.nix { inherit pkgs; })
		(import ./fzfp.nix { inherit pkgs; })
	];
}
