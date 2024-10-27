{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.gui.anki.enable = lib.mkEnableOption "Enable anki module";

  config = lib.mkIf config.apps.gui.anki.enable {
    home.packages = with pkgs; [
      anki
    ];
  };
}
