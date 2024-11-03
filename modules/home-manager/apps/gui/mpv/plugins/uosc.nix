{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.apps.gui.mpv.plugins.uosc;
in
{

  options.apps.gui.mpv.plugins.uosc.enable = lib.mkEnableOption "Enable mpv script uosc module";

  config.programs.mpv = lib.mkIf cfg.enable {
    scripts = with pkgs.mpvScripts; [
      uosc
    ];

    bindings = {
      tab = "script-binding uosc/toggle-ui";
      ">" = "script-binding uosc/next; script-message-to uosc flash-elements top_bar,timeline";
      "<" = "script-binding uosc/prev; script-message-to uosc flash-elements top_bar,timeline";
      "Alt+m" = "script-binding uosc/menu";
      "Alt+o" = "script-binding uosc/open-file";
      "Alt+p" = "script-binding uosc/items";
      # "space" = "cycle pause; script-binding uosc/flash-pause-indicator";
      # "right" = "seek 5";
      # "left" = "seek -5";
      # "shift+right" = "seek  30; script-binding uosc/flash-timeline";
      # "shift+left" = "seek -30; script-binding uosc/flash-timeline";
      # "m" = "no-osd cycle mute; script-binding uosc/flash-volume";
      # "up" = "no-osd add volume  10; script-binding uosc/flash-volume";
      # "down" = "no-osd add volume -10; script-binding uosc/flash-volume";
      # "[" = "no-osd add speed -0.25; script-binding uosc/flash-speed";
      # "]" = "no-osd add speed  0.25; script-binding uosc/flash-speed";
      # "\\" = "no-osd set speed 1; script-binding uosc/flash-speed";
    };
  };
}
