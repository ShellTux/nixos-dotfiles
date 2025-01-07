{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.apps.gui.mpv.plugins.mpv-cheatsheet;
in
{

  options.apps.gui.mpv.plugins.mpv-cheatsheet.enable =
    lib.mkEnableOption "Enable mpv script mpv-cheatsheet module";

  config.programs.mpv = lib.mkIf cfg.enable {
    scripts = with pkgs.mpvScripts; [
      mpv-cheatsheet
    ];
  };
}
