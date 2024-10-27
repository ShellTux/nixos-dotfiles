{ pkgs }:
pkgs.writeShellApplication {
  name = "fshow";

  runtimeInputs = with pkgs; [
    bash
    coreutils
    diff-so-fancy
    findutils
    fzf
    git
    gnugrep
  ];

  text = builtins.readFile ./fshow.sh;
}
