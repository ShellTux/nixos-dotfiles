{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.apps.gui.mpv.plugins.videoclip;
in
{

  options.apps.gui.mpv.plugins.videoclip.enable =
    lib.mkEnableOption "Enable mpv script videoclip module";

  config.programs.mpv = lib.mkIf cfg.enable {
    scripts = with pkgs.mpvScripts; [
      videoclip
    ];

    scriptOpts.videoclip = {
      video_folder_path = config.xdg.userDirs.videos;
      audio_folder_path = config.xdg.userDirs.music;
    };

    bindings = {
      "Alt+c" = "script-binding videoclip-menu-open";
    };
  };
}
