{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "mktouch";

  runtimeInputs = with pkgs; [
    coreutils
  ];

  text = builtins.readFile ./mktouch.sh;
}
