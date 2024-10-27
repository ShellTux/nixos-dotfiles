{ pkgs }:
pkgs.writeShellApplication {
  name = "ipa";

  runtimeInputs = with pkgs; [
    coreutils
    gnugrep
  ];

  text = builtins.readFile ./ipa.sh;
}
