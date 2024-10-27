{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.gui.jellyfin-media-player.enable = lib.mkEnableOption "Enable jellyfin-media-player module";

  config = lib.mkIf config.apps.gui.jellyfin-media-player.enable {
    home.packages = with pkgs; [
      jellyfin-media-player
    ];
  };
}
