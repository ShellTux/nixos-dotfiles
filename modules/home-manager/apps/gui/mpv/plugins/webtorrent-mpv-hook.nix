{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.apps.gui.mpv.plugins.webtorrent-mpv-hook;
in
{

  options.apps.gui.mpv.plugins.webtorrent-mpv-hook.enable =
    lib.mkEnableOption "Enable mpv script webtorrent-mpv-hook module";

  config.programs.mpv = lib.mkIf cfg.enable {
    scripts = with pkgs.mpvScripts; [
      webtorrent-mpv-hook
    ];

    scriptOpts.webtorrent = {
      path = "/tmp/webtorrent";
    };

    bindings = {
      "Alt+i" = "script-binding webtorrent/toggle-info";
    };
  };
}
