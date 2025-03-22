{ lib, pkgs, ... }:
let
  wallpaperScript = import ../wallpaper.nix { inherit pkgs; };
  waybarLoop = pkgs.writeShellApplication {
    name = "WAYBAR-LOOP";

    runtimeInputs = with pkgs; [
      waybar
    ];

    text = builtins.readFile ./waybar-loop.sh;
  };
in
{
  imports = [
    ./bind.nix
    ./decoration.nix
    ./input.nix
    ./windowrule.nix
    ./workspacerules.nix
  ];

  config.wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${pkgs.firewalld-gui}/bin/firewall-applet"
      "${pkgs.qpwgraph}/bin/qpwgraph --minimized"
      "${pkgs.networkmanagerapplet}/bin/nm-applet"
      "${pkgs.gammastep}/bin/gammastep-indicator"
    ];
    exec = [
      ''${wallpaperScript}/bin/wallpaperd daemon''
      ''${pkgs.syncthingtray}/bin/syncthingtray --single-instance --wait''
      ''${waybarLoop}/bin/WAYBAR-LOOP''
    ];

    env =
      let
        envVar = env: value: "${env}, ${value}";
      in
      [
        (envVar "GDK_BACKEND" "wayland,x11")
        (envVar "HYPRCURSOR_SIZE" "24")
        (envVar "XCURSOR_SIZE" "36")
      ];
    gestures = {
      workspace_swipe = "on";
      workspace_swipe_fingers = 3;
    };
    general = {
      border_size = 3;
      "col.active_border" = lib.mkDefault "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = lib.mkDefault "rgba(595959aa)";
      gaps_in = 5;
      gaps_out = 20;
      layout = "master";
    };
    misc = {
      enable_swallow = true;
      swallow_regex = "^(Alacritty|kitty|St)$";
      # HACK: swallow_exception_regex only works assuming parent window to be
      # swallowed changed to the title of swallower window
      # This can be achieved by defining a function in your shell `preexec` (zsh
      # only).
      # You can look up preexec for bash: https://github.com/rcaloras/bash-preexec
      swallow_exception_regex = "^(wev|ueberzugpp_.*|ranger)$";
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
    };

    "$altMod" = "ALT";
    "$mainMod" = "SUPER";
    "$TERMINAL" = "${pkgs.kitty}/bin/kitty";
    "$BROWSER" = "${pkgs.firefox}/bin/firefox";
    "$SCRATCHPAD" = "${pkgs.kitty}/bin/kitty";
  };
}
