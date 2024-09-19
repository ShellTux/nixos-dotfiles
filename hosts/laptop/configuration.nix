{ inputs, pkgs, config, settings, ... }:
{
	imports = [
		# Include the results of the hardware scan.
		./hardware-configuration.nix
		./home
	] ++ (with inputs.nixvim.nixosModules; [
		nixvim
	]) ++ (with inputs.sops-nix.nixosModules; [
		sops
	]) ++ (let path = ../../modules/nixos; in [
		(path + "/awesome.nix")
		(path + "/hyprland.nix")
		(path + "/i3.nix")
		(path + "/locate.nix")
		(path + "/networkmanager")
		(path + "/pipewire.nix")
		(path + "/plymouth.nix")
		(path + "/sddm")
		(path + "/sudo.nix")
		(path + "/wireshark.nix")
	]);

	sops = {
		defaultSopsFile = ../../secrets/secrets.yaml;
		defaultSopsFormat = "yaml";
		age.keyFile = "/var/lib/sops-nix/age/keys.txt";

		secrets = let
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
		};
	};

	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
		initrd.luks.devices."luks-37b20623-ff7f-4fdb-a6bf-73891a5a1eb7".device = "/dev/disk/by-uuid/37b20623-ff7f-4fdb-a6bf-73891a5a1eb7";
		kernelPackages = pkgs.linuxPackages_latest;
	};

	locate = { enable = true; pruneNixStore = false; extraPrunePaths = ["/var/local"]; };
	networkmanager.enable = true;
	pipewire.enable = true;
	plymouth.enable = false;
	sudo.enable = true;
	wireshark.enable = true;


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

	# Set your time zone.
	time.timeZone = "Europe/Lisbon";

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

		pipewire = {
			enable = true;
			alsa = {
				enable = true;
				support32Bit = true;
			};
			pulse.enable = true;
			# If you want to use JACK applications, uncomment this
			#jack.enable = true;

			# use the example session manager (no others are packaged yet so this is enabled by default,
			# no need to redefine it in your config for now)
			#media-session.enable = true;
		};

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
	# Enable sound with pipewire.
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	# TODO: Enable this for nixvim (Telescope man-pages) https://github.com/nix-community/nixvim/issues/1517
	documentation.man.generateCaches = true;

	# Install firefox.
	programs = {
		firefox.enable = true;
		zsh.enable = true;
		neovim = {
			enable = true;
			defaultEditor = true;
		};
	};

	nix = {
		settings = {
			experimental-features = [ "nix-command" "flakes" ];
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

	fonts.packages = with pkgs; [
		font-awesome
		jetbrains-mono
		noto-fonts-cjk

		(nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
	];

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

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.05"; # Did you read the comment?

}
