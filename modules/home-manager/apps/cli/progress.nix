{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.cli.progress.enable = lib.mkEnableOption "Enable progress module";

  config = lib.mkIf config.apps.cli.progress.enable {
    home = {
      packages = with pkgs; [
        progress
      ];
      shellAliases = {
        progress = "progress --wait-delay .5 --monitor-continuously";
      };
    };
  };
}
