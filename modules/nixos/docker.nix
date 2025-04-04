{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.docker.enable = lib.mkEnableOption "Enable docker module";

  config = lib.mkIf config.docker.enable {
    virtualisation.docker = {
      enable = true;

      enableOnBoot = false;
    };

    environment.systemPackages = with pkgs; [ docker-client ];
  };
}
