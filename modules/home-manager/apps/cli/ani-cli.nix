{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.cli.ani-cli.enable = lib.mkEnableOption "Enable ani-cli module";

  config = lib.mkIf config.apps.cli.ani-cli.enable {
    home.packages = with pkgs; [
      ani-cli
    ];
  };
}
