{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.gui.qbittorrent.enable = lib.mkEnableOption "Enable qbittorrent module";

  config = lib.mkIf config.apps.gui.qbittorrent.enable {
    home.packages = with pkgs; [
      qbittorrent
    ];
  };
}
