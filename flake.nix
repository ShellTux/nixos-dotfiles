{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		hosts.url = "github:StevenBlack/hosts";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		firefox-addons = {
			url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixvim = {
			url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# sop-nix = {
		# 	url = "github:Mic92/sops-nix";
		# 	inputs.nixpkgs.follows = "nixpkgs";
		# };

		pyprland.url = "github:hyprland-community/pyprland";

	};

	outputs = { self, nixpkgs, ... }@inputs:
	let
		system = "x86_64-linux";
		specialArgs = { inherit inputs; };
		mkNixosConfig = configFile: nixpkgs.lib.nixosSystem {
			inherit system specialArgs;
			modules = [
				configFile
			];
		};
	in
	{
		nixosConfigurations = {
			desktop = mkNixosConfig ./hosts/desktop/configuration.nix;
			laptop = mkNixosConfig ./hosts/laptop/configuration.nix;
			virtual-machine = mkNixosConfig ./hosts/virtual-machine/configuration.nix;
		};
	};
}
