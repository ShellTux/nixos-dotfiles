{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "help";

  runtimeInputs = with pkgs; [
    bat
  ];

  text = builtins.readFile ./help.sh;
}
