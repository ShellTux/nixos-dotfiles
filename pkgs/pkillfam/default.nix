{ pkgs, ... }:
pkgs.writeShellApplication {
	name = "pkillfam";

	text = builtins.readFile ./pkillfam.sh;
}
