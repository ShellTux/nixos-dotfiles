{ lib, pkgs, ... }:
{
  home = rec {
    username = "luisgois";
    homeDirectory = "/home/${username}";

    packages =
      let
        inherit (pkgs) callPackage;
      in
      [
        (callPackage ../../../pkgs/pkillfam { })
        (callPackage ../../../pkgs/help { })
        (callPackage ../../../pkgs/mktouch { })
        (callPackage ../../../pkgs/open { })
        (callPackage ../../../pkgs/vman { })
        (callPackage ../../../pkgs/gf { })
      ];

    sessionVariables = {
      EDITOR = "nvim";
    };

    sessionPath = [
      "$HOME/.local/bin"
    ];

    pointerCursor = lib.mkDefault {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    # file.".face.icon".source = builtins.fetchurl {
    # 	url = "https://avatars.githubusercontent.com/u/115948079?v=4";
    # 	sha256 = "a948791457c13ff836a81195c785e4f41c85b1204b19b9764424f8bc0b506a5d";
    # };

    shellAliases = lib.mkMerge [
      {
        cd1 = "cd ..";
        cd2 = "cd ../../";
        cd3 = "cd ../../../";
        cd4 = "cd ../../../../";
        cd5 = "cd ../../../../../";
        chmod = "chmod --changes";
        chown = "chown --changes";
        clang-format = "clang-format --verbose";
        cp = "cp --interactive --verbose";
        df = "df --human-readable";
        diff = "diff --color=auto";
        du = "du --human-readable";
        free = "free --human --wide --total";
        gdb = "gdb --tui";
        grep = "grep --colour=auto";
        install = "install --verbose";
        ip = "ip --color=auto";
        kernel = "uname --kernel-release";
        lower = ''tr "[:upper:]" "[:lower:]"'';
        lsblk-label = "lsblk -o name,fstype,mountpoint,label,partlabel,size";
        mkdir = "mkdir --parents --verbose";
        more = "less";
        nix-shell = ''nix-shell --command "$SHELL"'';
        mv = "mv --verbose";
        np = "nano --nowrap PKGBUILD";
        port = "netstat --tcp --udp --listening --all --numeric --program --wide";
        procs = "procs --watch-interval=.5 --watch";
        progress = "progress --wait-delay .5 --monitor-continuously";
        publicIP = ''printf '%s\n' "$(${pkgs.curl}/bin/curl --ipv4 --silent ifconfig.me)"'';
        ":q" = "exit";
        randomcolor = ''printf "#$(${pkgs.openssl}/bin/openssl rand -hex 3 | tr "[:lower:]" "[:upper:]")\n"'';
        rmdir = "rmdir --verbose --parents";
        rm = "rm --verbose --one-file-system --interactive=once";
        shred = "shred --verbose";
        sshfs = ''sshfs -o "compression=yes,reconnect"'';
        systemctl = "systemctl --lines=1000";
        upper = "tr \"[:lower:]\" \"[:upper:]\"";
        watch = "watch --color --interval 1";
      }
      # (genCdAliases 20)
    ];
  };

  imports = [
    ../common.nix
  ];

  # Hack to allow temporarily allow unfree packages
  # nixpkgs.config.allowUnfreePredicate = _: true;
  # nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "codeium"
      "codeium-vim"
      "codeium-nvim"
      "slack"
      "stremio-server"
      "stremio"
      "stremio-shell"
    ];

  apps = {
    cli = {
      aerc.enable = true;
      ani-cli.enable = true;
      bat.enable = true;
      bc.enable = true;
      btop.enable = true;
      dua.enable = true;
      eza.enable = true;
      fd.enable = true;
      ffmpeg = {
        enable = true;
        package = pkgs.ffmpeg-full;
      };
      fselect.enable = true;
      fzf.enable = true;
      gdb.enable = true;
      git.enable = true;
      htop.enable = true;
      khal.enable = true;
      mediainfo.enable = true;
      ncmpcpp.enable = true;
      neomutt.enable = true;
      neovim.enable = true;
      newsboat.enable = true;
      nh.enable = true;
      nvtop = {
        enable = true;
        backend = [ "intel" ];
      };
      procs.enable = true;
      progress.enable = true;
      qalculate.enable = true;
      silicon.enable = true;
      tealdeer.enable = true;
      tgpt.enable = true;
      tmux.enable = true;
      translate-shell.enable = true;
      unar.enable = true;
      vim.enable = true;
      yazi.enable = true;
      yt-dlp.enable = true;
      ytfzf.enable = true;
      zellij.enable = true;
    };
    gui = {
      anki.enable = true;
      browser.choices = [
        "floorp"
        "librewolf"
        "firefox"
      ];
      blender.enable = true;
      discord = {
        enable = true;
        flavours = [
          "webcord-vencord"
          "vesktop"
        ];
      };
      feh.enable = true;
      gtkhash.enable = true;
      imv.enable = true;
      jellyfin-media-player.enable = true;
      kitty.enable = true;
      mpv = {
        enable = true;

        plugins = {
          uosc.enable = true;
          videoclip.enable = true;
          quality-menu.enable = true;
          webtorrent-mpv-hook.enable = true;
          thumbfast.enable = true;
          mpv-playlistmanager.enable = true;
        };

      };
      nemo.enable = true;
      oculante.enable = true;
      prism-launcher.enable = true;
      qbittorrent.enable = true;
      qiv.enable = true;
      rofi.enable = true;
      slack.enable = true;
      stremio.enable = true;
      waybar.enable = true;
      wezterm.enable = true;
      xournalpp.enable = true;
      zathura.enable = true;
    };
  };

  styles.stylix.enable = true;

  accounts.enable = true;
  awesome.enable = true;
  bash.enable = true;
  direnv.enable = true;
  dunst.enable = true;
  hyprland.enable = true;
  i3.enable = true;
  mpd.enable = true;
  polkit.enable = true;
  ssh.enable = true;
  starship.enable = true;
  zsh.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
