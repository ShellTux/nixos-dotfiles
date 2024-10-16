{ config, ... }:
{
	# This value determines the Home Manager release that your configuration is
	# compatible with. This helps avoid breakage when a new Home Manager release
	# introduces backwards incompatible changes.
	#
	# You should not change this value, even if you update Home Manager. If you do
	# want to update the value, then make sure to first check the Home Manager
	# release notes.
	home.stateVersion = "24.05"; # Please read the comment before changing.

	imports = let path = ../../../modules/home-manager; in [
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

		mimeApps.enable = true;
	};

	nix = {
		settings.experimental-features = [ "nix-command" "flakes" ];
		gc = {
			automatic = true;
			options = "--delete-older-than 14d";
		};
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
