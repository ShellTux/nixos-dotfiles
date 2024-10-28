{ config, lib, ... }:
let
  cfg = config.users;
in
{
  imports = [
    ./user.nix
  ];

  config = lib.mkIf cfg.luisgois.enable {
    home-manager.users.luisgois = import ./home.nix;
  };
}
