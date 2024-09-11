{ pkgs }:
let
	kernel = import ./kernel.nix { };
	power = import ./power.nix { inherit pkgs; };
	weather = import ./weather.nix { };
	network-traffic = import ./network-traffic.nix { };
in 
{
	kernel = kernel;
	power = power;
	weather = weather;
	network-traffic = network-traffic;
}
