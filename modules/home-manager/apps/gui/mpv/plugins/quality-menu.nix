{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.apps.gui.mpv.plugins.quality-menu;
in
{

  options.apps.gui.mpv.plugins.quality-menu.enable = lib.mkEnableOption "Enable mpv script quality-menu module";

  config.programs.mpv = lib.mkIf cfg.enable {
    scripts = with pkgs.mpvScripts; [
      quality-menu
    ];

    bindings = {
      "F" = "script-binding quality_menu/video_formats_toggle";
      "Alt+f" = "script-binding quality_menu/audio_formats_toggle";
    };
  };
}
