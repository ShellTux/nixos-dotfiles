{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.awesome.enable = lib.mkEnableOption "Enable awesome module";

  config = lib.mkIf config.awesome.enable {
    home.packages = with pkgs; [
      kitty
      xclip
    ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      config.common.default = [ "gtk" ];
    };

    xsession.windowManager.awesome = {
      enable = true;
    };
  };
}
