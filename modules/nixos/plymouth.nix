{
  lib,
  pkgs,
  config,
  ...
}:
{
  options = {
    plymouth.enable = lib.mkEnableOption "Enable plymouth module";
  };

  config = lib.mkIf config.plymouth.enable {
    environment.systemPackages = with pkgs; [
      nixos-bgrt-plymouth
    ];

    boot = {
      plymouth = {
        enable = true;

        theme = "bgrt";
        themePackages = with pkgs; [
          # By default we would install all themes
          (adi1090x-plymouth-themes.override {
            selected_themes = [ ];
          })
        ];
      };

      kernelParams = [
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];
    };
  };
}
