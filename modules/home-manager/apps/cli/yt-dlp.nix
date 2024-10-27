{ lib, config, ... }:
{
  options.apps.cli.yt-dlp.enable = lib.mkEnableOption "Enable yt-dlp module";

  config = lib.mkIf config.apps.cli.yt-dlp.enable {
    programs.yt-dlp = {
      enable = true;

      settings = {
        embed-thumbnail = true;
        embed-subs = true;
        embed-metadata = true;
        embed-chapters = true;
        sub-langs = "all";
        format = ''"bestvideo[height<=1440]+bestaudio/best"'';
        # downloader = "aria2c";
        # downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
      };
    };
  };
}
