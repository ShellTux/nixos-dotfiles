{ inputs, pkgs, username, ... }:
{
	home = {
		inherit username;
		homeDirectory = "/home/${username}";

                sessionVariables = {
                  EDITOR = "nvim";
                };

                sessionPath = [
                  "$HOME/.local/bin"
                  ];

		stateVersion = "24.05"; # Please read the comment before changing.
	};

	imports = let path = ../../modules/home-manager; in [
		(path + "/alacritty.nix")
		(path + "/bat.nix")
		(path + "/btop.nix")
		(path + "/direnv.nix")
		(path + "/eza.nix")
		(path + "/fd.nix")
		(path + "/firefox.nix")
		(path + "/fzf.nix")
		(path + "/git")
		(path + "/htop.nix")
		(path + "/kitty.nix")
		(path + "/mpv.nix")
		(path + "/neovim")
		(path + "/shell")
		(path + "/ssh.nix")
		(path + "/starship.nix")
		(path + "/tealdeer.nix")
		(path + "/tmux.nix")
		(path + "/vim.nix")
		(path + "/wezterm")
		(path + "/window-managers/wayland/hyprland")
		(path + "/yazi.nix")
		(path + "/yt-dlp.nix")
		(path + "/zathura.nix")
	] ++ [
		inputs.nixvim.homeManagerModules.nixvim
	];

	alacritty.enable = true;
	bash.enable = true;
	bat.enable = true;
	btop.enable = true;
	direnv.enable = true;
	eza.enable = true;
	fd.enable = true;
	# firefox.enable = true;
	fzf.enable = true;
	git.enable = true;
	htop.enable = true;
	hyprland.enable = true;
	kitty.enable = true;
	mpv.enable = true;
	neovim.enable = true;
	# ssh.enable = true;
	starship.enable = true;
	tealdeer.enable = true;
	tmux.enable = true;
	vim.enable = true;
	wezterm.enable = true;
	yazi.enable = true;
	yt-dlp.enable = true;
	zathura.enable = true;
	zsh.enable = true;

	programs.home-manager.enable = true;
}
