{ pkgs }:
pkgs.writeShellApplication {
  name = "brightness";

  runtimeInputs = with pkgs; [
    brightnessctl
    coreutils
    gawk
    gnused
    libnotify
  ];
  text = builtins.readFile ./brightness.sh;
}
