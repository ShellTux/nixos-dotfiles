{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.gui.blender.enable = lib.mkEnableOption "Enable blender module";

  config = lib.mkIf config.apps.gui.blender.enable {
    home.packages = with pkgs; [
      blender
    ];
  };
}
