{ pkgs }:
let
	workspaces = import ./workspaces.nix { inherit pkgs; };
in 
{
	workspaces = workspaces;
}
