{ pkgs, ... }:
let
  brightnessScript = import ../../../brightness.nix { inherit pkgs; };
  volumeScript = import ../../../volume.nix { inherit pkgs; };
  rofi = pkgs.rofi.override {
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji
    ];
  };
in
{
  config.wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod, Return, exec, $TERMINAL"
      "$mainMod, C, killactive, "
      "$mainMod, P, exec, ${pkgs.wofi}/bin/wofi --allow-images --show drun"
      "$mainMod SHIFT, Q, exec, hyprctl dispatch exit"

      "$mainMod, Space, togglefloating, "
      "$altMod, Tab, cyclenext, "
      "$mainMod, F, fullscreen, 0"

      "$mainMod, H, movefocus, l"
      "$mainMod, L, movefocus, r"
      "$mainMod, K, movefocus, u"
      "$mainMod, J, movefocus, d"

      # Switch workspaces with mainMod + [0-9]"
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"
      "$mainMod, right, workspace, e+1"
      "$mainMod, left, workspace, e-1"
      "$mainMod, U, focusurgentorlast"
      "$mainMod, TAB, focusurgentorlast"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"
      "$mainMod CTRL SHIFT, right, movetoworkspace, e+1"
      "$mainMod CTRL SHIFT, left, movetoworkspace, e-1"

      "$mainMod SHIFT, Tab, movecurrentworkspacetomonitor, +1"

      # Screenshots
      ", PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot --mode=output"
      "$mainMod, PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot --mode=window"
      "$mainMod SHIFT, PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot --mode=region"

      # Emojis
      "$mainMod, period, exec, ${rofi}/bin/rofi -show emoji"

      # wlogout
      "$mainMod, F4, exec, ${pkgs.wlogout}/bin/wlogout --protocol layer-shell"

      # Pin Window (Sticky)
      "$mainMod ALT, S, pin, active"

      # Monocle
      "$mainMod SHIFT, m, exec, hyprctl dispatch fullscreen 1"

      # Zoom
      "$mainMod, Plus, exec, ${pkgs.woomer}/bin/woomer"

    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"

      # Center floating window
      "$mainMod, mouse:274, centerwindow"
    ];

    bindl = [
      # Music
      ", XF86AudioPlay, exec, ${pkgs.mpc-cli}/bin/mpc toggle"
      ", XF86AudioPrev, exec, ${pkgs.mpc-cli}/bin/mpc prev"
      ", XF86AudioNext, exec, ${pkgs.mpc-cli}/bin/mpc next"
    ];

    bindle = [
      # Volume
      ", XF86AudioRaiseVolume, exec, ${volumeScript}/bin/volume 5 +"
      ", XF86AudioLowerVolume, exec, ${volumeScript}/bin/volume 5 -"
      "SHIFT, XF86AudioRaiseVolume, exec, ${volumeScript}/bin/volume 1 +"
      "SHIFT, XF86AudioLowerVolume, exec, ${volumeScript}/bin/volume 1 -"
      ", XF86AudioMute, exec, ${volumeScript}/bin/volume toggle-mute"

      # Brightness
      ", XF86MonBrightnessUp,    exec, ${brightnessScript}/bin/brightness 5 +"
      ", XF86MonBrightnessDown,  exec, ${brightnessScript}/bin/brightness 5 -"
    ];
  };
}
