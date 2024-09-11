{ pkgs }:
let
	window = import ./window.nix { };
	language = import ./language.nix { };
	workspaces = import ./workspaces.nix { inherit pkgs; };
	submap = import ./submap.nix { };
in
{
	window = window;
	language = language;
	workspaces = workspaces;
	submap = submap;
}
