{ lib, config, ... }:
{
  options.apps.gui.feh.enable = lib.mkEnableOption "Enable feh module";

  config = lib.mkIf config.apps.gui.feh.enable {
    programs.feh = {
      enable = true;
    };
  };
}
