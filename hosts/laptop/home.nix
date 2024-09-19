{ inputs, lib, pkgs, config, username, users, ... }:
let
  genCdAliases = len:
    let
      strRepeat0 = str: acc: n: if n == 0 then str else strRepeat0 (acc + str) acc (n - 1);
      strRepeat = str: n: strRepeat0 str str n;
      alias = strRepeat "." len;
      pathStr = strRepeat "../" len;

      genCdAliases0 = depth: attrs:
        if depth <= 1 then attrs
        else (genCdAliases0 (depth - 1) attrs) //
          { ${builtins.substring 0 depth alias} = ("cd " + builtins.substring 0 ((depth - 1) * 3) pathStr); };
    in
    genCdAliases0 len {};
in
{
	home = {
		username = username;
		homeDirectory = users.${username}.home;

		packages = with pkgs; [
			(callPackage ../../pkgs/pkillfam { })
		];

		sessionVariables = {
			EDITOR = "nvim";
		};

		sessionPath = [
			"$HOME/.local/bin"
		];

		file.".face.icon".source = builtins.fetchurl {
			url = "https://avatars.githubusercontent.com/u/115948079?v=4";
			sha256 = "a948791457c13ff836a81195c785e4f41c85b1204b19b9764424f8bc0b506a5d";
		};

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
			open = "xdg-open";
			port = "netstat --tcp --udp --listening --all --numeric --program --wide";
			procs = "procs --watch-interval=.5 --watch";
			progress = "progress --wait-delay .5 --monitor-continuously";
			publicIP = ''printf '%s\n' "$(${pkgs.curl}/bin/curl --ipv4 --silent ifconfig.me)"'';
			":q" = "exit";
			randomcolor = ''printf "#$(${pkgs.openssl}/bin/openssl rand -hex 3 | tr "[:lower:]" "[:upper:]")\n"'';
			rmdir = "rmdir --verbose --parents";
			rm = "rm --verbose --one-file-system --interactive=once";
			shred = "shred --verbose";
			silicon = ''silicon --theme OneHalfDark --font "FiraCode Nerd Font"'';
			sshfs = ''sshfs -o "compression=yes,reconnect"'';
			upper = "tr \"[:lower:]\" \"[:upper:]\"";
			watch = "watch --color --interval 1";
		}
		(genCdAliases 20)
		];

		# This value determines the Home Manager release that your configuration is
		# compatible with. This helps avoid breakage when a new Home Manager release
		# introduces backwards incompatible changes.
		#
		# You should not change this value, even if you update Home Manager. If you do
		# want to update the value, then make sure to first check the Home Manager
		# release notes.
		stateVersion = "24.05"; # Please read the comment before changing.
	};

	imports = let path = ../../modules/home-manager; in [
		(path + "/accounts")
		(path + "/apps")
		(path + "/direnv.nix")
		(path + "/dunst.nix")
		(path + "/mpd")
		(path + "/polkit.nix")
		(path + "/shell")
		(path + "/ssh.nix")
		(path + "/starship.nix")
		(path + "/window-managers/wayland/hyprland")
		(path + "/window-managers/x11/awesome")
		(path + "/window-managers/x11/i3")
	] ++ [
		inputs.nixvim.homeManagerModules.nixvim
	];

	apps = {
		cli = {
			ani-cli.enable = true;
			bat.enable = true;
			btop.enable = true;
			dua.enable = true;
			eza.enable = true;
			fd.enable = true;
			ffmpeg = { enable = true; package = pkgs.ffmpeg-full; };
			fselect.enable = true;
			fzf.enable = true;
			git.enable = true;
			htop.enable = true;
			khal.enable = true;
			mediainfo.enable = true;
			ncmpcpp.enable = true;
			neomutt.enable = true;
			neovim.enable = true;
			newsboat.enable = true;
			nvtop = { enable = true; backend = [ "intel" ]; };
			procs.enable = true;
			progress.enable = true;
			qalculate.enable = true;
			tealdeer.enable = true;
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
			discord = { enable = true; flavours = [ "webcord-vencord" "vesktop" ]; };
			firefox.enable = true;
			gtkhash.enable = true;
			imv.enable = true;
			jellyfin-media-player.enable = true;
			kitty.enable = true;
			mpv.enable = true;
			nemo.enable = true;
			qbittorrent.enable = true;
			rofi.enable = true;
			slack.enable = true;
			stremio.enable = true;
			waybar.enable = true;
			wezterm.enable = true;
			zathura.enable = true;
		};
	};

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

	nixpkgs.config.allowUnfreePredicate = pkg:
		builtins.elem (lib.getName pkg) [
		"codeium"
		"slack"
	];

	xdg = {
		enable = true;

		userDirs = let
			homeDirectory = config.home.homeDirectory;
		in {
			enable = true;

			createDirectories = true;

			desktop = "${homeDirectory}/Área de Trabalho";
			documents = "${homeDirectory}/Documentos";
			download = "${homeDirectory}/Transferências";
			music = "${homeDirectory}/Música";
			pictures = "${homeDirectory}/Imagens";
			publicShare = "${homeDirectory}/Público";
			templates = "${homeDirectory}/Modelos";
			videos = "${homeDirectory}/Vídeos";
		};

		configFile."user-dirs.locale".text = "pt_PT";
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
