{ ... }:
{
  home = rec {
    username = "user";
    homeDirectory = "/home/${username}";
  };

  imports = [
    ../common.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
