{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  config.wayland.windowManager.hyprland.settings.decoration = {
    blur = {
      enabled = "yes";
      new_optimizations = "on";
      passes = 1;
      size = 3;
    };
    active_opacity = 1.0;
    inactive_opacity = 0.6;
    fullscreen_opacity = 1.0;
    rounding = 10;
    shadow = {
      enabled = true;
      color = mkDefault "rgba(1a1a1aee)";
      offset = "0 5";
      range = 4;
      render_power = 3;
    };
  };
}
