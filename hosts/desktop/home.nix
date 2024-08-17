{ inputs, lib, pkgs, username, ... }:
{
	home = {
		inherit username;
		homeDirectory = "/home/${username}";
		stateVersion = "24.05"; # Please read the comment before changing.
	};

	programs.home-manager.enable = true;
}
