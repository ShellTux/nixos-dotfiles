{ lib, config, ... }:
{
  options.apps.cli.translate-shell.enable = lib.mkEnableOption "Enable translate-shell module";

  config = lib.mkIf config.apps.cli.translate-shell.enable {
    programs.translate-shell.enable = true;
  };
}
