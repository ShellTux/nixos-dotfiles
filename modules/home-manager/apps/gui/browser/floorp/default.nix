{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.apps.gui.floorp;
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

      profiles = {
        "${config.home.username}" = {
          name = "${config.home.username}";
          isDefault = true;

          extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
            bitwarden
            darkreader
            (lib.mkIf config.apps.gui.firefox.enableFf2mpv ff2mpv)
            return-youtube-dislikes
            search-by-image
            sponsorblock
            tridactyl
            ublock-origin
            vimium
            xbrowsersync
          ];
        };
      };

      languagePacks = [
        "pt-PT"
        "en-US"
      ];

      nativeMessagingHosts = [
        (lib.mkIf cfg.enableFf2mpv pkgs.ff2mpv)
      ];
    };
  };
}
