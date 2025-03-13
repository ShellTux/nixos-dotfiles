{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (builtins)
    any
    elemAt
    head
    length
    map
    ;
  inherit (lib) mkOption mkIf;
  inherit (lib.types) listOf enum;
  cfg = config.apps.gui.browser;
in
{
  options.apps.gui.browser = {
    choices = mkOption {
      description = "Which browser to install. The first one will be the default mimeapp for urls.";
      type = listOf (enum [
        "firefox"
        "floorp"
        "librewolf"
      ]);
      default = [ ];
      example = [
        "librewolf"
        "floorp"
      ];
    };
  };

  imports = [
    ./firefox
    ./floorp
    ./librewolf
  ];

  config = {
    apps.gui = {
      firefox.enable = any (x: x == "firefox") cfg.choices;
      librewolf.enable = any (x: x == "librewolf") cfg.choices;
      floorp.enable = any (x: x == "floorp") cfg.choices;
    };

    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
        ];
      };
      mimeApps = {
        defaultApplications = mkIf (length cfg.choices >= 1) (
          let
            m = head (map (choice: "${choice}.desktop") cfg.choices);
          in
          {
            "application/x-extension-htm" = m;
            "application/x-extension-html" = m;
            "application/x-extension-shtml" = m;
            "application/x-extension-xht" = m;
            "application/x-extension-xhtml" = m;
            "application/xhtml+xml" = m;
            "text/html" = m;
            "x-scheme-handler/chrome" = m;
            "x-scheme-handler/http" = m;
            "x-scheme-handler/https" = m;
          }
        );
        associations.added = mkIf (length cfg.choices >= 2) (
          let
            m = elemAt (map (choice: "${choice}.desktop") cfg.choices) 1;
          in
          {
            "application/x-extension-htm" = m;
            "application/x-extension-html" = m;
            "application/x-extension-shtml" = m;
            "application/x-extension-xht" = m;
            "application/x-extension-xhtml" = m;
            "application/xhtml+xml" = m;
            "text/html" = m;
            "x-scheme-handler/chrome" = m;
            "x-scheme-handler/http" = m;
            "x-scheme-handler/https" = m;
          }
        );
      };
    };
  };
}
