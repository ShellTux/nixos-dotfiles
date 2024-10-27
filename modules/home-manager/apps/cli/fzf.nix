{ lib, config, ... }:
{
  options.apps.cli.fzf.enable = lib.mkEnableOption "Enable fzf module";

  config = lib.mkIf config.apps.cli.fzf.enable {
    programs.fzf = {
      enable = true;
    };

    home.shellAliases = {
      fzf = ''fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'';
    };
  };
}
