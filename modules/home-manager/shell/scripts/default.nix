{ pkgs, ... }:
{
	home.packages = [
		(import ./fzfp.nix { inherit pkgs; })
		(import ./ipa.nix { inherit pkgs; })
		(import ./nix-path.nix { inherit pkgs; })
	];
}
