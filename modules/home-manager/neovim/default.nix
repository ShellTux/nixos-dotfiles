{ pkgs, lib, config, ... }:
let
	plugins = import ./plugins/default.nix { inherit pkgs lib ;};
	keymaps = import ./keymaps.nix { };
	settings = import ./settings.nix { };
	colorschemes = import ./colorschemes.nix { };
in
{
	options = {
		neovim = {
			enable = lib.mkEnableOption "Enable neovim module";
			nixvim.enable = lib.mkEnableOption "Enable neovim configuration through nixvim" // {
				default = true;
			};
		};
		# TODO: Option to enable clipboard managers x11/wayland
		# TODO: Option to enable installing neovim external tools
	};

	config = lib.mkIf config.neovim.enable {
		nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
			"codeium"
		];

		programs.nixvim = lib.mkIf config.neovim.nixvim.enable {
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

			extraConfigLua = ''
				require('render-markdown').setup({})
			'';
		};

		programs.neovim = lib.mkIf (config.neovim.nixvim.enable == false) {
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
