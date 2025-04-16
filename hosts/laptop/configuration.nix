{
  inputs,
  pkgs,
  config,
  settings,
  lib,
  ...
}:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../home
    ]
    ++ (with inputs.nixvim.nixosModules; [
      nixvim
    ])
    ++ (with inputs.sops-nix.nixosModules; [
      sops
    ])
    ++ (
      let
        path = ../../modules/nixos;
      in
      [
        (path + "/awesome.nix")
        (path + "/boot")
        (path + "/docker.nix")
        (path + "/hyprland.nix")
        (path + "/i3.nix")
        (path + "/libvirt.nix")
        (path + "/locate.nix")
        (path + "/networkmanager")
        (path + "/pipewire.nix")
        (path + "/sddm")
        (path + "/stylix")
        (path + "/sudo.nix")
        (path + "/wireshark.nix")
      ]
    );

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/sops-nix/age/keys.txt";

    secrets =
      let
        userSettings = {
          owner = config.users.users."${settings.user.username}".name;
          group = config.users.users."${settings.user.username}".group;
        };
      in
      {
        "Email/Gmail/Work/password" = userSettings;
        "Email/Dei/password" = userSettings;
        "Ssh/Github/Private-key" = userSettings;
        "Ssh/Gitlab/Private-key" = userSettings;
        "Ssh/Git.Dei/Private-key" = userSettings;
        "Ssh/Gitea/Private-key" = userSettings;
        "Rss/Changedetection/url" = userSettings;
        "Rss/Es2024-pl3/AssignedIssues/url" = userSettings;
        "Rss/Es2024-pl3/Issues/url" = userSettings;
        "Rss/Es2024-pl3/Activity/url" = userSettings;
        "Rss/Es2024-pl3/MergeRequests/url" = userSettings;
        "Rss/Es2024-pl3/Commits/url" = userSettings;
      };
  };

  boot = {
    loader = {
      backend = "grub";
      efi.canTouchEfiVariables = true;
    };
    plymouth.enable = true;
    initrd.luks.devices."luks-37b20623-ff7f-4fdb-a6bf-73891a5a1eb7".device =
      "/dev/disk/by-uuid/37b20623-ff7f-4fdb-a6bf-73891a5a1eb7";
    kernelPackages = pkgs.linuxPackages_latest;
  };

  users = {
    luisgois.enable = true;
    user.enable = true;
  };

  docker.enable = true;
  libvirt.enable = true;
  locate = {
    enable = true;
    pruneNixStore = false;
    extraPrunePaths = [ "/var/local" ];
  };
  networkmanager.enable = true;
  pipewire.enable = true;
  sudo.enable = true;
  wireshark.enable = true;

  styles.stylix.enable = true;

  # Enable networking
  networking = {
    hostName = settings.system.hostname;
    networkmanager.enable = true;
    #proxy.default = "http://user:password@proxy:port/";
    #proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    firewall = {
      enable = true;
      logReversePathDrops = true;
      extraCommands = ''
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
      '';
      extraStopCommands = ''
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
      '';
    };
    stevenblack = {
      enable = true;

      block = [
        "fakenews"
        "gambling"
      ];
    };
    extraHosts = builtins.readFile ./hosts;
  };

  i18n = {
    defaultLocale = "pt_PT.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "pt_PT.UTF-8";
      LC_IDENTIFICATION = "pt_PT.UTF-8";
      LC_MEASUREMENT = "pt_PT.UTF-8";
      LC_MONETARY = "pt_PT.UTF-8";
      LC_NAME = "pt_PT.UTF-8";
      LC_NUMERIC = "pt_PT.UTF-8";
      LC_PAPER = "pt_PT.UTF-8";
      LC_TELEPHONE = "pt_PT.UTF-8";
      LC_TIME = "pt_PT.UTF-8";
    };
  };

  time.timeZone = lib.mkForce settings.system.timezone;

  # List services that you want to enable:
  services = {
    xserver = {
      enable = true;

      xkb = {
        layout = "pt";
        variant = "";
      };
    };

    displayManager.sddm.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    desktopManager.plasma6.enable = true;

    spice-vdagentd.enable = true;

    # Configure keymap in X11

    # Enable CUPS to print documents.
    printing.enable = true;

    pulseaudio.enable = false;
    pipewire.enable = true;

    openssh = {
      enable = true;
      startWhenNeeded = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = false;
        AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
        PrintMotd = true;
        # banner = '''';
      };
    };

    fail2ban.enable = true;

    automatic-timezoned.enable = true;
  };

  # Configure console keymap
  console.keyMap = "pt-latin1";
  hardware = {
    opentabletdriver.enable = true;
  };
  security.rtkit.enable = true;
  # TODO: Enable this for nixvim (Telescope man-pages) https://github.com/nix-community/nixvim/issues/1517
  documentation.man.generateCaches = true;

  # Install firefox.
  programs = {
    firefox.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    zsh.enable = true;
  };

  nix = {
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment = {
    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      bat
      curl
      fastfetch
      ffmpeg
      firefox
      home-manager
      htop
      imv
      kitty
      man-db
      man-pages
      man-pages-posix
      ncdu
      neofetch
      neovim
      ntfs3g
      sl
      sops
      spice-vdagent
      tmux
      tree
      vim
      virt-viewer
      wireguard-tools
      wl-clipboard
      xclip
    ];
  };

  fonts.packages =
    with pkgs;
    [
      font-awesome
      jetbrains-mono
      noto-fonts-cjk-sans
    ]
    ++ (with pkgs.nerd-fonts; [
      symbols-only
    ]);

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  awesome.enable = true;
  hyprland.enable = true;
  i3.enable = true;

  # https://github.com/NixOS/nixpkgs/security/advisories/GHSA-m7pq-h9p4-8rr4
  systemd.shutdownRamfs.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
