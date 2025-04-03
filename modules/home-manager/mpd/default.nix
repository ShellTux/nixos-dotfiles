{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (builtins) readFile;
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) bool;
  inherit (pkgs) writeShellApplication;
  cfg = config.mpd;
  notify-music = writeShellApplication {
    name = "notify-music";

    runtimeInputs = [
      pkgs.coreutils
      pkgs.mpc-cli
      pkgs.gawk
      pkgs.libnotify
    ];

    text = builtins.readFile ./notify-music.sh;
  };

  mpd-notification = writeShellApplication {
    name = "mpd-notification";

    runtimeInputs = [
      notify-music
      pkgs.coreutils
      pkgs.mpc-cli
      pkgs.libnotify
      pkgs.xdg-user-dirs
      pkgs.ffmpeg
    ];

    text = readFile ./mpd-notification.sh;
  };
in
{
  options.mpd = {
    enable = mkEnableOption "Enable mpd module";

    install = {
      mpc = mkOption {
        description = "Whether to install the mpc cli.";
        type = bool;
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    services.mpd = {
      enable = true;

      network.startWhenNeeded = true;

      extraConfig = readFile ./extraConfig.conf;
      playlistDirectory = "${config.services.mpd.musicDirectory}/.mpd_playlists";
    };

    home.packages = [
      (mkIf cfg.install.mpc pkgs.mpc-cli)
      mpd-notification
      notify-music
    ];

    systemd.user.services.mpd-notification = {
      Unit = {
        Description = "MPD Notification";
        Requires = "dbus.socket";
        PartOf = "graphical-session.target";
        After = [
          "mpd.service"
          "network.target"
          "network-online.target"
          "graphical-session.target"
          "swaync.service"
        ];
      };

      Service = {
        Type = "notify";
        Restart = "on-failure";
        ExecStart = "${mpd-notification}/bin/mpd-notification";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
