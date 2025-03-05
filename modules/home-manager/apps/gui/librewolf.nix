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

    defaultMimeApp = lib.mkOption {
      description = "Whether to make librewolf the default app to open links";
      type = lib.types.bool;
      default = false;
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
      mimeApps =
        let
          mimeApp = "librewolf.desktop";
          applications = {
            "application/x-extension-htm" = mimeApp;
            "application/x-extension-html" = mimeApp;
            "application/x-extension-shtml" = mimeApp;
            "application/x-extension-xht" = mimeApp;
            "application/x-extension-xhtml" = mimeApp;
            "application/xhtml+xml" = mimeApp;
            "text/html" = mimeApp;
            "x-scheme-handler/chrome" = mimeApp;
            "x-scheme-handler/http" = mimeApp;
            "x-scheme-handler/https" = mimeApp;
          };
        in
        {
          defaultApplications = (lib.mkIf config.apps.gui.librewolf.defaultMimeApp applications);
          associations.added = (lib.mkIf (config.apps.gui.librewolf.defaultMimeApp != true) applications);
        };
    };
  };
}
