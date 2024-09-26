{ pkgs, lib, config, inputs, ... }:
let
	plugins = import ./plugins { inherit pkgs lib ;};
	keymaps = import ./keymaps.nix { };
	settings = import ./settings.nix { };
	colorschemes = import ./colorschemes.nix { };
in
{
	imports = with inputs.nixvim.homeManagerModules; [
		nixvim
	];

	options.apps.cli.neovim = {
		enable = lib.mkEnableOption "Enable neovim module";
		nixvim.enable = lib.mkEnableOption "Enable neovim configuration through nixvim" // {
			default = true;
		};
	};

	config = lib.mkIf config.apps.cli.neovim.enable {
		nixpkgs.config.apps.cli.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
			"codeium"
		];

		programs.nixvim = lib.mkIf config.apps.cli.neovim.nixvim.enable {
			enable = true;

			clipboard.providers = {
				wl-copy.enable = true;
				xclip.enable = true;
			};

			colorscheme = lib.mkForce "tokyonight";
			colorschemes = colorschemes;
			globals = settings.globals;
			opts = settings.opts;
			plugins = plugins.nixvim;
			keymaps = keymaps;

			extraPlugins = with pkgs.vimPlugins; [
				render-markdown
			];

			extraConfigLua = let
				extraPlugins = config.programs.nixvim.extraPlugins;
			in with pkgs.vimPlugins; lib.strings.concatStrings [
				(if (lib.elem render-markdown extraPlugins) then ''
				 require('render-markdown').setup({})
				 '' else "")
			];
		};

		programs.neovim = lib.mkIf (config.apps.cli.neovim.nixvim.enable == false) {
			enable = true;

			defaultEditor = true;

			extraLuaConfig = lib.fileContents ./init.lua;

			plugins = plugins.neovim;

			extraPackages = with pkgs; [
				wl-clipboard
				xclip
			];
		};

		home.packages = with pkgs; [
			ripgrep
			wl-clipboard
			xclip
		];
	};
}
