{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
let
cfg = config.styles.stylix;
in
{
	imports = with inputs.stylix.nixosModules; [
		stylix
	];

	options.styles.stylix = {
		enable = lib.mkEnableOption "Enable stylix";

		polarity = lib.mkOption {
			description = "Which stylix polarity";
			type = lib.types.enum [ "light" "dark" ];
			default = "dark";
		};

		autoEnable = lib.mkOption {
			description = "Target all applications by default";
			type = lib.types.bool;
			default = true;
		};

		colorscheme = lib.mkOption {
			description = "Colorscheme";
			type = lib.types.enum [
				"3024"
				"apathy"
				"apprentice"
				"ashes"
				"atelier-cave-light"
				"atelier-cave"
				"atelier-dune-light"
				"atelier-dune"
				"atelier-estuary-light"
				"atelier-estuary"
				"atelier-forest-light"
				"atelier-forest"
				"atelier-heath-light"
				"atelier-heath"
				"atelier-lakeside-light"
				"atelier-lakeside"
				"atelier-plateau-light"
				"atelier-plateau"
				"atelier-savanna-light"
				"atelier-savanna"
				"atelier-seaside-light"
				"atelier-seaside"
				"atelier-sulphurpool-light"
				"atelier-sulphurpool"
				"atlas"
				"ayu-dark"
				"ayu-light"
				"ayu-mirage"
				"aztec"
				"bespin"
				"black-metal-bathory"
				"black-metal-burzum"
				"black-metal-dark-funeral"
				"black-metal-gorgoroth"
				"black-metal-immortal"
				"black-metal-khold"
				"black-metal-marduk"
				"black-metal-mayhem"
				"black-metal-nile"
				"black-metal-venom"
				"black-metal"
				"blueforest"
				"blueish"
				"brewer"
				"bright"
				"brogrammer"
				"brushtrees-dark"
				"brushtrees"
				"caroline"
				"catppuccin-frappe"
				"catppuccin-latte"
				"catppuccin-macchiato"
				"catppuccin-mocha"
				"chalk"
				"circus"
				"classic-dark"
				"classic-light"
				"codeschool"
				"colors"
				"cupcake"
				"cupertino"
				"da-one-black"
				"da-one-gray"
				"da-one-ocean"
				"da-one-paper"
				"da-one-sea"
				"da-one-white"
				"danqing-light"
				"danqing"
				"darcula"
				"darkmoss"
				"darktooth"
				"darkviolet"
				"decaf"
				"default-dark"
				"default-light"
				"dirtysea"
				"dracula"
				"edge-dark"
				"edge-light"
				"eighties"
				"embers-light"
				"embers"
				"emil"
				"equilibrium-dark"
				"equilibrium-gray-dark"
				"equilibrium-gray-light"
				"equilibrium-light"
				"eris"
				"espresso"
				"eva-dim"
				"eva"
				"evenok-dark"
				"everforest-dark-hard"
				"everforest"
				"flat"
				"framer"
				"fruit-soda"
				"gigavolt"
				"github"
				"google-dark"
				"google-light"
				"gotham"
				"grayscale-dark"
				"grayscale-light"
				"greenscreen"
				"gruber"
				"gruvbox-dark-hard"
				"gruvbox-dark-medium"
				"gruvbox-dark-pale"
				"gruvbox-dark-soft"
				"gruvbox-light-hard"
				"gruvbox-light-medium"
				"gruvbox-light-soft"
				"gruvbox-material-dark-hard"
				"gruvbox-material-dark-medium"
				"gruvbox-material-dark-soft"
				"gruvbox-material-light-hard"
				"gruvbox-material-light-medium"
				"gruvbox-material-light-soft"
				"hardcore"
				"harmonic16-dark"
				"harmonic16-light"
				"heetch-light"
				"heetch"
				"helios"
				"hopscotch"
				"horizon-dark"
				"horizon-light"
				"horizon-terminal-dark"
				"horizon-terminal-light"
				"humanoid-dark"
				"humanoid-light"
				"ia-dark"
				"ia-light"
				"icy"
				"irblack"
				"isotope"
				"jabuti"
				"kanagawa"
				"katy"
				"kimber"
				"lime"
				"macintosh"
				"marrakesh"
				"materia"
				"material-darker"
				"material-lighter"
				"material-palenight"
				"material-vivid"
				"material"
				"measured-dark"
				"measured-light"
				"mellow-purple"
				"mexico-light"
				"mocha"
				"monokai"
				"moonlight"
				"mountain"
				"nebula"
				"nord-light"
				"nord"
				"nova"
				"ocean"
				"oceanicnext"
				"one-light"
				"onedark"
				"outrun-dark"
				"oxocarbon-dark"
				"oxocarbon-light"
				"pandora"
				"papercolor-dark"
				"papercolor-light"
				"paraiso"
				"pasque"
				"phd"
				"pico"
				"pinky"
				"pop"
				"porple"
				"precious-dark-eleven"
				"precious-dark-fifteen"
				"precious-light-warm"
				"precious-light-white"
				"primer-dark-dimmed"
				"primer-dark"
				"primer-light"
				"purpledream"
				"qualia"
				"railscasts"
				"rebecca"
				"rose-pine-dawn"
				"rose-pine-moon"
				"rose-pine"
				"saga"
				"sagelight"
				"sakura"
				"sandcastle"
				"selenized-black"
				"selenized-dark"
				"selenized-light"
				"selenized-white"
				"seti"
				"shades-of-purple"
				"shadesmear-dark"
				"shadesmear-light"
				"shapeshifter"
				"silk-dark"
				"silk-light"
				"snazzy"
				"solarflare-light"
				"solarflare"
				"solarized-dark"
				"solarized-light"
				"spaceduck"
				"spacemacs"
				"sparky"
				"standardized-dark"
				"standardized-light"
				"stella"
				"still-alive"
				"summercamp"
				"summerfruit-dark"
				"summerfruit-light"
				"synth-midnight-dark"
				"synth-midnight-light"
				"tango"
				"tarot"
				"tender"
				"tokyo-city-dark"
				"tokyo-city-light"
				"tokyo-city-terminal-dark"
				"tokyo-city-terminal-light"
				"tokyo-night-dark"
				"tokyo-night-light"
				"tokyo-night-moon"
				"tokyo-night-storm"
				"tokyo-night-terminal-dark"
				"tokyo-night-terminal-light"
				"tokyo-night-terminal-storm"
				"tokyodark-terminal"
				"tokyodark"
				"tomorrow-night-eighties"
				"tomorrow-night"
				"tomorrow"
				"tube"
				"twilight"
				"unikitty-dark"
				"unikitty-light"
				"unikitty-reversible"
				"uwunicorn"
				"vesper"
				"vice"
				"vulcan"
				"windows-10-light"
				"windows-10"
				"windows-95-light"
				"windows-95"
				"windows-highcontrast-light"
				"windows-highcontrast"
				"windows-nt-light"
				"windows-nt"
				"woodland"
				"xcode-dusk"
				"zenbones"
				"zenburn"
			];
			default = "onedark";
		};
	};

	config.stylix = lib.mkIf cfg.enable {
		enable = true;

		image = ./wallpaper.jpg;
		imageScalingMode = "stretch";
		base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.colorscheme}.yaml";

		polarity = cfg.polarity;

		homeManagerIntegration = {
			autoImport = false;
			followSystem = true;
		};

		cursor = {
			name = "Bibata-Modern-Classic";
			package = pkgs.bibata-cursors;
			size = 24;
		};

		fonts = {
			monospace = {
				package = pkgs.jetbrains-mono;
				name = "JetBrains Mono";
			};
			sansSerif = {
				package = pkgs.dejavu_fonts;
				name = "DejaVu Sans";
			};
			serif = {
				package = pkgs.dejavu_fonts;
				name = "DejaVu Serif";
			};
			emoji = {
				package = pkgs.noto-fonts-color-emoji;
				name = "Noto Color Emoji";
			};
		};

		opacity = {
			popups = 0.9;
			terminal = 0.8;
		};

		autoEnable = cfg.autoEnable;
	};
}
