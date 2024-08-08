{ inputs, pkgs, ... }:
let
  keys = [
  ];
in
{
  users.users = {
    luisgois = {
      isNormalUser = true;
      home = "/home/luisgois";
      extraGroups = [
        "audio"
        "wheel"
	"networkmanager"
      ];
      shell = pkgs.zsh;
      uid = 1000;
      openssh.authorizedKeys.keys = keys;
    };
    root.openssh.authorizedKeys.keys = keys;
  };

  imports = [
  ];
}
