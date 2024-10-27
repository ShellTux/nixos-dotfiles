{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.i3.enable = lib.mkEnableOption "Enable i3 module";

  config = lib.mkIf config.i3.enable {
    services.xserver.windowManager.i3 = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      dunst
      firefox
      kitty
      libnotify
    ];

    xdg.portal = {
      enable = true;

      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };

    hardware.graphics.enable = true;
  };
}
