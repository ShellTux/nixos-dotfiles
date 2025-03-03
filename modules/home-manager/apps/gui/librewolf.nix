{
  pkgs,
  lib,
  config,
  inputs,
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

      profiles = {
        default = {
          extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
            bitwarden
            darkreader
            (lib.mkIf config.apps.gui.librewolf.enableFf2mpv ff2mpv)
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
    };

    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
        ];
      };
      mimeApps.associations.added = {
        "application/x-extension-htm" = [ "librewolf.desktop" ];
        "application/x-extension-html" = [ "librewolf.desktop" ];
        "application/x-extension-shtml" = [ "librewolf.desktop" ];
        "application/x-extension-xht" = [ "librewolf.desktop" ];
        "application/x-extension-xhtml" = [ "librewolf.desktop" ];
        "application/xhtml+xml" = [ "librewolf.desktop" ];
        "text/html" = [ "librewolf.desktop" ];
        "x-scheme-handler/chrome" = [ "librewolf.desktop" ];
        "x-scheme-handler/http" = [ "librewolf.desktop" ];
        "x-scheme-handler/https" = [ "librewolf.desktop" ];
      };
    };
  };
}
