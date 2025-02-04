{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.gui.oculante.enable = lib.mkEnableOption "Enable oculante module";

  config = lib.mkIf config.apps.gui.oculante.enable {
    home.packages = [ pkgs.oculante ];
  };
}
