{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.apps.gui.mpv.plugins.mpv-playlistmanager;
in
{

  options.apps.gui.mpv.plugins.mpv-playlistmanager.enable =
    lib.mkEnableOption "Enable mpv script mpv-playlistmanager module";

  config.programs.mpv = lib.mkIf cfg.enable {
    scripts = with pkgs.mpvScripts; [
      mpv-playlistmanager
    ];
  };
}
