{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:NixOs/nixpkgs/nixos-24.05";
		nixos-hardware.url = "github:NixOS/nixos-hardware/master";

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

		sops-nix = {
			url = "github:Mic92/sops-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		pyprland = {
			url = "github:hyprland-community/pyprland";
			inputs.nixpkgs.follows = "nixpkgs";
		};

	};

	outputs = { self, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, ... }@inputs:
	let
		system = "x86_64-linux";
		specialArgs = { inherit inputs; };
		extraSpecialArgs = {
			inherit inputs;
			isServer = false;
			isDarwin = false;
			isLinux = true;
		};
		mkNixosConfig = configFile: nixpkgs.lib.nixosSystem {
			inherit system specialArgs;
			modules = [ configFile ];
		};
		mkHomeManagerConfig = configFile: system: home-manager.lib.homeManagerConfiguration {
			inherit extraSpecialArgs;
			pkgs = nixpkgs.legacyPackages.${system};
			pkgs-stable = nixpkgs-stable.legacyPackages.${system};
			modules = [ configFile ];
		};
	in
	{
		nixosConfigurations = {
			nixos-desktop = mkNixosConfig ./hosts/desktop/configuration.nix;
			nixos-laptop = mkNixosConfig ./hosts/laptop/configuration.nix;
			nixos-virtual-machine = mkNixosConfig ./hosts/virtual-machine/configuration.nix;
		};
		homeConfigurations = {
			desktop = mkHomeManagerConfig ./hosts/desktop/home.nix system;
			laptop = mkHomeManagerConfig ./hosts/laptop/home.nix system;
		};
	};
}
