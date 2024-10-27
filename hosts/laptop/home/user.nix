{ lib, pkgs, ... }:
let
  username = "user";
in
{
  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  imports = [
    ./common.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
