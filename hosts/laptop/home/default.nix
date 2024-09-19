{ inputs, config, pkgs, ... }:
let
	createUser = username: shell: {
		isNormalUser = true;
		home = "/home/${username}";
		initialPassword = "123456";
		extraGroups = [
			"audio"
			"wheel"
			"networkmanager"
		];
		shell = shell;
	};
in 
{
	imports = with inputs.home-manager.nixosModules; [
		home-manager
	];

	home-manager = {
		extraSpecialArgs = {
			inherit inputs;
			secrets = config.sops.secrets;
		};
		users = {
			luisgois = import ./luisgois.nix;
			user = import ./user.nix;
		};
	};

	users = {
		motd = "";
		users = {
			luisgois = (createUser "luisgois" pkgs.zsh);
			user = (createUser "user" pkgs.bash);
		};
	};
}
