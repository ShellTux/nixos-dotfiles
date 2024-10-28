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

    stylix.url = "github:danth/stylix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      nixos-hardware,
      home-manager,
      ...
    }@inputs:
    let
      settings = {
        system = {
          arch = "x86_64-linux";
          hostname = "LuisGoisNixOS";
          timezone = "Europe/Lisbon";
          locale = "pt_PT.UTF-8";
        };
        user = {
          username = "luisgois";
        };
      };

      pkgs = nixpkgs.legacyPackages.${settings.system.arch};

      specialArgs = {
        inherit inputs settings;
      };
      extraSpecialArgs = {
        inherit inputs settings;
        isServer = false;
        isDarwin = false;
        isLinux = true;
      };
      mkNixosConfig =
        configFile:
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [ configFile ];
        };
      mkHomeManagerConfig =
        configFile: system:
        home-manager.lib.homeManagerConfiguration {
          inherit extraSpecialArgs;
          pkgs = nixpkgs.legacyPackages.${settings.system.arch};
          pkgs-stable = nixpkgs-stable.legacyPackages.${settings.system.arch};
          modules = [ configFile ];
        };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

      nixosConfigurations = {
        nixos-desktop = mkNixosConfig ./hosts/desktop/configuration.nix;
        nixos-laptop = mkNixosConfig ./hosts/laptop/configuration.nix;
        nixos-virtual-machine = mkNixosConfig ./hosts/virtual-machine/configuration.nix;
      };
      homeConfigurations = {
        luisgois = mkHomeManagerConfig ./home/users/luisgois/home.nix settings.system.arch;
        user = mkHomeManagerConfig ./home/users/user/home.nix settings.system.arch;
      };

      devShells.x86_64-linux.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          git
          git-crypt
          gitleaks
          nixfmt-rfc-style
          pre-commit
          sops
        ];

        shellHook = ''
          printf '\033[32m%s\033[0m\n' 'Installing Pre-commit hooks'
          pre-commit install
        '';
      };
    };
}
