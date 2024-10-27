{
  lib,
  config,
  pkgs,
  ...
}:
let
  neomutt.colorschemes = {
    gruvbox = pkgs.fetchFromGitHub {
      owner = "shuber2";
      repo = "mutt-gruvbox";
      rev = "91853cfee609ecad5d2cb7dce821a7dfe6d780ef";
      hash = "sha256-TFxVG2kp5IDmkhYuzhprEz2IE28AEMAi/rUHILa7OPU=";
    };
    dracula = pkgs.fetchFromGitHub {
      owner = "dracula";
      repo = "mutt";
      rev = "3072ba9aa0af9781c1f9d361e4c8e736c1349ed1";
      hash = "sha256-mn4mGGxt4XG3lm+lBTTQxV73ljBizs+JkHV9qPwfqxg=";
    };
    catppuccin = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "neomutt";
      rev = "f6ce83da47cc36d5639b0d54e7f5f63cdaf69f11";
      hash = "sha256-ye16nP2DL4VytDKB+JdMkBXU+Y9Z4dHmY+DsPcR2EG0=";
    };
  };
in
{
  options.apps.cli.neomutt = {
    enable = lib.mkEnableOption "Enable neomutt module";

    enableMbsync = lib.mkOption {
      description = "Whether to enable mbsync.";
      type = lib.types.bool;
      default = true;
    };

    colorscheme = lib.mkOption {
      description = "Which colorscheme to pick for neomutt.";
      type = lib.types.enum [
        "dracula"
        "catppuccin"
        "gruvbox"
        "neonwolf-256"
        "solarized-dark-256"
        "vombatidae"
        "zenburn"
      ];
      default = "solarized-dark-256";
    };
  };

  imports = [
    ./binds.nix
    ./macros.nix
  ];

  config = lib.mkIf config.apps.cli.neomutt.enable {
    programs.neomutt = {
      enable = true;

      checkStatsInterval = 60;
      sidebar = {
        enable = true;
        format = "%B%?F? [%F]?%* %?N?%N/?%S";
      };
      sort = "reverse-threads";
      vimKeys = true;
      settings = {
        include = "yes";
        forward_format = ''"Fwd: %s"'';
        query_command = ''"${pkgs.abook}/bin/abook --mutt-query '%s'"'';
        timeout = "5";
        wait_key = "no";
      };

      extraConfig =
        let
          colorscheme = config.apps.cli.neomutt.colorscheme;
          findAllMailboxes = (import ./findAllMailboxes.nix { inherit pkgs; });
        in
        lib.mkMerge [
          (lib.mkIf (colorscheme == "catppuccin") "source ${neomutt.colorschemes.catppuccin}/neomuttrc")
          (lib.mkIf (colorscheme == "dracula") "source ${neomutt.colorschemes.dracula}/dracula.muttrc")
          (lib.mkIf (
            colorscheme == "gruvbox"
          ) "source ${neomutt.colorschemes.gruvbox}/colors-gruvbox-shuber.muttrc")
          (lib.mkIf (
            colorscheme == "neonwolf-256"
          ) "source ${pkgs.neomutt}/share/doc/neomutt/colorschemes/neonwolf-256.neomuttrc")
          (lib.mkIf (
            colorscheme == "solarized-dark-256"
          ) "source ${pkgs.neomutt}/share/doc/neomutt/colorschemes/solarized-dark-256.neomuttrc")
          (lib.mkIf (
            colorscheme == "vombatidae"
          ) "source ${pkgs.neomutt}/share/doc/neomutt/colorschemes/vombatidae.neomuttrc")
          (lib.mkIf (
            colorscheme == "zenburn"
          ) "source ${pkgs.neomutt}/share/doc/neomutt/colorschemes/zenburn.neomuttrc")
          "auto_view text/html"
          ''named-mailboxes `${findAllMailboxes}/bin/find-mailboxes.sh "${config.accounts.email.maildirBasePath}"`''
        ];
    };

    services.mbsync.enable = lib.mkIf config.apps.cli.neomutt.enableMbsync true;
    programs.mbsync.enable = lib.mkIf config.apps.cli.neomutt.enableMbsync true;

    xdg = {
      desktopEntries.neomutt = {
        name = "Neomutt";
        genericName = "Email Client";
        comment = "Read and send emails";
        exec = "neomutt %U";
        icon = "mutt";
        terminal = true;
        categories = [
          "Network"
          "Email"
          "ConsoleOnly"
        ];
        type = "Application";
        mimeType = [ "x-scheme-handler/mailto" ];
      };
      mimeApps.defaultApplications."x-scheme-handler/mailto" = "neomutt.desktop";
    };

    accounts.email.accounts =
      let
        defaultNeomuttConfig = {
          neomutt.enable = true;
          mbsync = {
            enable = true;

            create = "maildir";
          };
        };
      in
      lib.mkIf config.accounts.email.enable {
        gmail-work = defaultNeomuttConfig;
        dei = defaultNeomuttConfig;
      };
  };
}
