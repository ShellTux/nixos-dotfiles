{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.apps.gui.cursor;
in
{
  options.apps.gui.cursor.enable = mkEnableOption "Enable cursor module";

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.code-cursor
    ];
  };
}
