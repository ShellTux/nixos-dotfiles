{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.pyprland.enable = lib.mkEnableOption "Enable pyprland module";

  config = lib.mkIf config.pyprland.enable {
    home.packages = with pkgs; [
      btop
      htop
      hyprpicker
      libqalculate
      (ncmpcpp.override {
        visualizerSupport = true;
        clockSupport = true;
        taglibSupport = true;
      })
      pyprland
      yazi
    ];

    xdg.configFile."hypr/pyprland.toml".text = builtins.readFile ./pyprland.toml;

    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "${pkgs.pyprland}/bin/pypr"
      ];

      bind = [
        "$mainMod , Z, exec, pypr zoom ++0.5"
        "$mainMod SHIFT, Z, exec, pypr zoom"

        "$mainMod, B, exec, pypr toggle btop"
        "$mainMod, E, exec, pypr toggle yazi"
        "$mainMod, M, exec, pypr toggle ncmpcpp"
        "$mainMod, R, exec, pypr toggle htop"
        "$mainMod, N, exec, pypr toggle nvtop"
        "$mainMod, S, exec, pypr toggle term"
        "$mainMod, X, exec, pypr toggle qalc"

        "$mainMod, backslash, exec, pypr toggle-dpms"

        "$mainMod SHIFT, apostrophe, exec, pypr menu"
      ];
    };
  };
}
