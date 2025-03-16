{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.apps.gui.librewolf = {
    enable = lib.mkEnableOption "Enable librewolf module";

    enableFf2mpv = lib.mkOption {
      description = "Wether to enable the ff2mpv extension.";
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.apps.gui.librewolf.enable {
    programs.librewolf = {
      enable = true;

      package = pkgs.librewolf.override {
        cfg.speechSynthesisSupport = false;
      };

      settings =
        let
          ffVersion = builtins.substring 0 5 pkgs.librewolf.version;
        in
        {
          "browser.compactmode.show" = true;
          "browser.startup.page" = 3;
          "extensions.unifiedExtensions.enabled" = false;
          "general.useragent.override" =
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:${ffVersion}) Gecko/20100101 Firefox/${ffVersion}";
          "general.platform.override" = "Win32";
          "identity.fxaccounts.enabled" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "network.cookie.lifetimePolicy" = 0;
          "privacy.clearOnShutdown.cookies" = false;
          "privacy.clearOnShutdown.history" = false;
          "privacy.firstparty.isolate" = true;
          "privacy.resistFingerprinting" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "webgl.disabled" = false;
        };
    };
  };
}
