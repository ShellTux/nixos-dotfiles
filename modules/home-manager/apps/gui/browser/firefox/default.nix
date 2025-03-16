{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.apps.gui.firefox = {
    enable = lib.mkEnableOption "Enable firefox module";

    enableFf2mpv = lib.mkOption {
      description = "Wether to enable the ff2mpv extension.";
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.apps.gui.firefox.enable {
    programs.firefox = {
      enable = true;

      package = (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true; }) { });

      nativeMessagingHosts = with pkgs; [
        (lib.mkIf config.apps.gui.firefox.enableFf2mpv ff2mpv)
      ];
    };
  };
}
