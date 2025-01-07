{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.apps.gui.mpv.plugins.thumbfast;
in
{

  options.apps.gui.mpv.plugins.thumbfast.enable =
    lib.mkEnableOption "Enable mpv script thumbfast module";

  config.programs.mpv = lib.mkIf cfg.enable {
    scripts = with pkgs.mpvScripts; [
      thumbfast
    ];
  };
}
