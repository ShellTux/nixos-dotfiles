{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.gui.planify.enable = lib.mkEnableOption "Enable planify module";

  config = lib.mkIf config.apps.gui.planify.enable {
    home.packages = with pkgs; [
      planify
    ];
  };
}
