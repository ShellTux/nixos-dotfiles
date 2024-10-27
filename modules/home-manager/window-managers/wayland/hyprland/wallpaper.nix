{ pkgs }:
pkgs.writeShellApplication {
  name = "wallpaperd";

  runtimeInputs = with pkgs; [
    coreutils
    findutils
    swww
  ];

  text = builtins.readFile ./wallpaper.sh;
}
