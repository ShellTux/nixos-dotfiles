{
  pkgs,
  lib,
  config,
  ...
}:
let
  username = "luisgois";
  cfg = config.users.${username};
in
{
  config.users.users.${username} = lib.mkIf cfg.enable {
    isNormalUser = true;
    home = "/home/${username}";
    initialPassword = "123456";
    extraGroups = [
      "audio"
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };
}
