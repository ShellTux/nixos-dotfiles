{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "open";

  runtimeInputs = with pkgs; [
    coreutils
    xdg-utils
  ];

  text = builtins.readFile ./open.sh;
}
