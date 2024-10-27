{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "find-mailboxes.sh";

  runtimeInputs = with pkgs; [
    coreutils
    findutils
  ];

  text = builtins.readFile ./find-mailboxes.sh;
}
