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

	};

	outputs = { self, nixpkgs, ... }@inputs:
		let
		system = "x86_64-linux";
	pkgs = {
		inherit system;

		config = {
			allowUnfree = true;
		};
	};
	in
	{
		nixosConfigurations = {
			default = nixpkgs.lib.nixosSystem {
				modules = [
					./hosts/default/configuration.nix
				];
				extraSpecialArgs = {inherit inputs;};
			};
			desktop = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./hosts/desktop/configuration.nix
				];
				specialArgs = {inherit inputs;};
			};
			laptop = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./hosts/laptop/configuration.nix
				];
				specialArgs = {inherit inputs;};
			};
			virtual-machine = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./hosts/virtual-machine/configuration.nix
						inputs.home-manager.nixosModules.default
				];
				specialArgs = { inherit inputs system; };
			};
		};
	};
}
