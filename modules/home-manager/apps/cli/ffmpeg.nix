{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.cli.ffmpeg = {
    enable = lib.mkEnableOption "Enable ffmpeg module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.ffmpeg;
      description = "The ffmpeg package to use.";
    };
  };

  config = lib.mkIf config.apps.cli.ffmpeg.enable {
    home.packages = [
      config.apps.cli.ffmpeg.package
    ];
  };
}
