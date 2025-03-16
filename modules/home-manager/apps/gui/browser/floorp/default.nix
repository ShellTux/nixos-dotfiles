{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.apps.gui.floorp;
  inherit (config.home) username;
in
{
  options.apps.gui.floorp = {
    enable = lib.mkEnableOption "Enable floorp module";

    enableFf2mpv = lib.mkOption {
      description = "Wether to enable the ff2mpv extension.";
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.apps.gui.floorp.enable {
    programs.floorp = {
      enable = true;

      nativeMessagingHosts = [
        (lib.mkIf cfg.enableFf2mpv pkgs.ff2mpv)
      ];
    };
  };
}
