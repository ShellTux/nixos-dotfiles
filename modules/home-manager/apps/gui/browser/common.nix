{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.home) username;
  inherit (lib) mkIf;

  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
  lock-empty-string = {
    Value = "";
    Status = "locked";
  };

  fa = inputs.firefox-addons.packages.x86_64-linux;
  firefoxBasedCommon = {
    languagePacks = [
      "pt-PT"
      "en-US"
    ];

    profiles = {
      ${config.home.username} = {
        name = "${config.home.username}";
        isDefault = true;

        extensions.packages = [
          fa.bitwarden
          fa.darkreader
          fa.material-icons-for-github
          fa.return-youtube-dislikes
          fa.search-by-image
          fa.sponsorblock
          fa.tridactyl
          fa.ublock-origin
          fa.vimium
          fa.xbrowsersync
          (mkIf config.apps.gui.librewolf.enableFf2mpv fa.ff2mpv)
        ];

        settings = {
          "general.autoScroll" = true;
          "mousewheel.default.delta_multiplier_y" = 100;
          "widget.disable-workspace-management" = true;
          "intl.accept_languages" = "pt-PT, en-US, en";
        };

        search =
          let
            Bing = "bing";
            DuckDuckGo = "ddg";
            Ecosia = "ecosia";
            Google = "google";
            Qwant = "qwant";
            Searx = "searx";
            Startpage = "startpage";
            Wikipedia = "wikipedia";
          in
          {
            force = true;
            default = DuckDuckGo;
            order = [
              DuckDuckGo
              Startpage
              Google
              Searx
              "Google Académico"
              "Swiss cows"
              "Brave Search"
              Qwant
              "Gigablast"
              "Qmamu"
              Ecosia
            ];
            engines = {
              "Home Manager Options" = {
                urls = [
                  { template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master"; }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [
                  "!hm"
                  "!hmo"
                  "@hmo"
                ];
              };

              GitHub = {
                urls = [ { template = "https://github.com/search?q={searchTerms}"; } ];
                icon = "https://github.com/fluidicon.png";
                updateInterval = 7 * 24 * 60 * 60 * 1000;
                definedAliases = [
                  "!git"
                  "@git"
                  "@gh"
                  "!github"
                  "@github"
                ];
              };

              ${Wikipedia}.metaData.alias = "!wiki";
              ${Google}.metaData = {
                hidden = true;
                alias = "!g";
              };

              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages?query={searchTerms}&type=packages";
                  }
                ];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [
                  "!np"
                  "!nix"
                  "@nix"
                  "!np"
                  "@np"
                  "!nixpackages"
                  "@nixpackages"
                ];
              };

              "NixOS Wiki" = rec {
                urls = [ { template = "https://wiki.nixos.org/index.php?search={searchTerms}"; } ];
                icon = "https://wiki.nixos.org/favicon.png";
                iconUpdateURL = icon;
                updateInterval = 24 * 60 * 60 * 1000; # every day
                definedAliases = [
                  "!nixos"
                  "@nixos"
                  "@nw"
                ];
              };

              ${Bing}.metaData.hidden = true;
            };
          };
      };
    };
  };

  policies = {
    policies = {
      DisableAccounts = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisplayBookmarksToolbar = "always"; # never, always, newtab
      DisplayMenuBar = "default-off"; # default-off, "always", "never", "default-on"
      DontCheckDefaultBrowser = true;
      SearchBar = "unified"; # unified, separate

      Preferences = {
        "extensions.pocket.enabled" = lock-false;
        "browser.newtabpage.pinned" = lock-empty-string;
        "browser.topsites.contile.enabled" = lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
      };
    };
  };
in
{
  config = {
    programs = {
      firefox = firefoxBasedCommon // policies;
      floorp = firefoxBasedCommon // policies;
      librewolf = firefoxBasedCommon;
    };

    stylix.targets.firefox.profileNames = [ "${username}" ];
    stylix.targets.floorp.profileNames = [ "${username}" ];
    stylix.targets.librewolf.profileNames = [ "${username}" ];
  };
}
