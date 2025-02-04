{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.gui.qiv.enable = lib.mkEnableOption "Enable qiv module";

  config = lib.mkIf config.apps.gui.qiv.enable {
    home.packages = [ pkgs.qiv ];
  };
}
