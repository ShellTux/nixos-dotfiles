{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    hyprland.enable = lib.mkEnableOption "Enable hyprland module";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;

      xwayland.enable = true;
    };

    services.hypridle = {
      enable = true;
    };

    programs.hyprlock = {
      enable = true;
    };

    environment.sessionVariables = {
      # If your cursor becomes invisible
      WLR_NO_HARDWARE_CURSORS = "1";
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };

    environment.systemPackages = with pkgs; [
      dunst
      firefox
      hyprpaper
      kitty
      libnotify
      mpvpaper
      waybar
      wofi
    ];

    xdg.portal = {
      enable = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
    };

    hardware.graphics.enable = true;
  };
}
