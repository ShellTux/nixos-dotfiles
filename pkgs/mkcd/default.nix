{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "mkcd";

  runtimeInputs = with pkgs; [
    coreutils
  ];

  text = builtins.readFile ./mkcd.sh;
}
