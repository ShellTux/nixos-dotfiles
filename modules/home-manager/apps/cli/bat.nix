{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.apps.cli.bat.enable = lib.mkEnableOption "Enable bat module";

  config = lib.mkIf config.apps.cli.bat.enable {
    programs.bat = {
      enable = true;

      config = {
        pager = "less --RAW-CONTROL-CHARS";
        theme = lib.mkDefault "TwoDark";
        map-syntax = [
          "*.ino:C++"
          ".ignore:Git Ignore"
          "aliasrc:Bourne Again Shell (bash)"
          "bash_profile:Bourne Again Shell (bash)"
          "bashrc:Bourne Again Shell (bash)"
          "*.conf:INI"
          "dunstrc:INI"
        ];
      };

      extraPackages = with pkgs.bat-extras; [
        batdiff
        batgrep
        batman
        batpipe
        batwatch
      ];
    };

    home = {
      shellAliases = {
        bathelp = "bat --plain --language=help";
      };
      sessionVariables = {
        MANPAGER = "sh -c 'col --no-backspaces --spaces | bat --language man --plain'";
        MANROFFOPT = "-c";
      };
    };
  };
}
