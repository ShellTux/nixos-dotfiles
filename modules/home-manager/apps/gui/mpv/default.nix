{ lib, config, ... }:
let
  inherit (lib) mkForce;
in
{
  imports = [
    ./plugins
  ];

  options.apps.gui.mpv.enable = lib.mkEnableOption "Enable mpv module";

  config = lib.mkIf config.apps.gui.mpv.enable {
    programs.mpv = {
      enable = true;

      config = {
        # Audio
        volume = "50";
        ao = "pipewire,pulse,alsa";

        # Subtitles
        slang = "por-PT,pt-PT,pt,por,por-BR,pt-BR,eng,en,jpn,ja";
        subs-with-matching-audio = "yes";
        # ISO 639 language codes source:
        # https://www.loc.gov/standards/iso639-2/php/code_list.php
        # https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes

        # Screenshot
        screenshot-template = "%F_%P";
        screenshot-directory = "~/Imagens/MPV Screenshots";

        osd-font-size = mkForce 20;
        sub-font-size = mkForce 34;
      };

      profiles = {
        "extension.gif" = {
          loop-file = "inf";
        };

        "big-cache" = {
          cache = "yes";
          demuxer-max-bytes = "1GiB";
        };

        "network" = {
          profile-cond = "demuxer_via_network == true";
          profile-desc = "Profile for content over the network";
          profile = "big-cache";
        };

        "1080p" = {
          ytdl-format = "ytdl-format=bestvideo[height<=?1080]+bestaudio/best";
        };

        "720p" = {
          ytdl-format = "ytdl-format=bestvideo[height<=?720]+bestaudio/best";
        };

        "480p" = {
          ytdl-format = "ytdl-format=bestvideo[height<=?480]+bestaudio/best";
        };

        "360p" = {
          ytdl-format = "ytdl-format=bestvideo[height<=?360]+bestaudio/best";
        };
      };
    };
  };
}
