{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "vman";

  text = builtins.readFile ./vman.sh;
}
