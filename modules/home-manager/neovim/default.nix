{ pkgs, lib, config, ... }:
let
	leader = " ";
in
{
	options = {
		neovim.enable = lib.mkEnableOption "Enable neovim module";
		nixvim.enable = lib.mkEnableOption "Enable neovim configuration through nixvim" // {
			default = true;
		};
		# TODO: Option to enable clipboard managers x11/wayland
		# TODO: Option to enable installing neovim external tools
	};

	config = lib.mkIf config.neovim.enable {
		nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
			"codeium"
		];

		programs.nixvim = lib.mkIf config.nixvim.enable {
			enable = true;

			clipboard.providers = {
				wl-copy.enable = true;
				xclip.enable = true;
			};

			colorscheme = lib.mkForce "tokyonight";
			colorschemes = {
				catppuccin.enable = true;
				dracula.enable = true;
				everforest.enable = true;
				gruvbox.enable = true;
				kanagawa.enable = true;
				nightfox.enable = true;
				nord.enable = true;
				onedark.enable = true;
				tokyonight.enable = true;
				vscode.enable = true;
			};
			globals = {
				mapleader = leader;
				maplocalleader = leader;
				favorite_colorschemes = [
					"adwaita"
					"carbonfox"
					"catppuccin"
					"darkplus"
					"duskfox"
					"github_dark"
					"gruvbox"
					"kanagawa"
					"kanagawa-dragon"
					"nightfox"
					"nordfox"
					"onedark"
					"terafox"
					"tokyonight"
					"vscode"
				];
			};
			opts = {
				background = "dark";
				encoding = "UTF-8";
				exrc = true;
				hlsearch   = true;
				ignorecase = true;
				incsearch  = true;
				linebreak  = false;
				listchars = "tab:> ,trail:•,nbsp:~";
				# mouse:append('a');
				mouse = "nvia";
				number         = true;
				relativenumber = false;
				scrolloff      = 999;
				sidescrolloff  = 10;
				signcolumn     = "yes";
				smartcase      = true;
				syntax         = "enabled";
				termguicolors  = true;
				textwidth      = 80;
				wildignore     = "*.o,*.a,__pycache__";
				wildmenu       = true;
				wrap           = false;
			};
			plugins = {
				auto-save.enable = true;
				bufferline = {
					enable = true;

					diagnostics = "nvim_lsp";
					diagnosticsIndicator = ''
					function(count, level, diagnostics_dict, context)
						local s = " "
						for e, n in pairs(diagnostics_dict) do
							local sym = e == "error" and " "
							    or (e == "warning" and " " or "")
							s = s .. n .. sym
						end
						return s
					end
					'';
					offsets = [
						{ filetype = "NvimTree"; }
					];
					mode = "tabs";
					hover = {
						enabled = true;
						reveal = [ "close" ];
					};
				};
				chadtree.enable = true;
				cloak = {
					enable = true;

					settings = {
						enabled = true;

						cloak_character = "*";
						highlight_group = "Comment";
						patterns = [
						{
							cloak_pattern = "=.+";
							file_pattern = [
								".env*"
								"wrangler.toml"
								".dev.vars"
							];
						}
						];
					};
					
				};
				cmp.enable = true;
				codeium-vim = {
					enable = true;

					settings = {
						enabled = lib.mkForce false;
						filetypes_disabled_by_default = true;
						filetypes = {
							bash = true;
							cpp = true;
							css = true;
							c = true;
							dart = true;
							"." = false;
							gitcommit = false;
							gitrebase = false;
							go = true;
							help = false;
							html = true;
							javascript = true;
							java = true;
							kotlin = true;
							lua = true;
							markdown = true;
							php = true;
							python = true;
							rust = true;
							sh = true;
							swift = true;
							typescript = true;
						};
					};
				};
				codesnap = {
					enable = true;

					settings = {
						breadcrumbs_separator = "/";
						has_breadcrumbs = true;
						has_line_number = false;
						mac_window_bar = true;
						# TODO: Change directory according to nixos configuration
						save_path = "~/Imagens/CodeSnapScreenshots";
						title = "CodeSnap.nvim";
						watermark = "";
					};
				};
				friendly-snippets.enable = true;
				fugitive.enable = true;
				gitsigns = {
					enable = true;

					settings = {
						current_line_blame = false;
						current_line_blame_opts.delay = 1000;
						linehl     = false;
						numhl      = true;
						signcolumn = true;
						word_diff  = false;
					};
				};
				indent-blankline = {
					enable = true;

					settings = {
						exclude = {
							buftypes = [
								"terminal"
								"quickfix"
							];
							filetypes = [
								""
								"''"
								"checkhealth"
								"gitcommit"
								"help"
								"lspinfo"
								"man"
								"packer"
								"TelescopePrompt"
								"TelescopeResults"
								"yaml"
							];
						};
						indent = {
							tab_char = "";
							# highlight = [
							# 	"RainbowRed"
							# 	"RainbowYellow"
							# 	"RainbowBlue"
							# 	"RainbowOrange"
							# 	"RainbowGreen"
							# 	"RainbowViolet"
							# 	"RainbowCyan"
							# ];
						};
					};
				};
				lastplace = {
					enable = true;

					ignoreBuftype = [
						"quickfix"
						"nofix"
						"nofile"
						"help"
					];
					ignoreFiletype = [
						"gitcommit"
						"gitrebase"
						"svn"
						"hgcommit"
					];
					openFolds = true;
				};
				lsp = {
					enable = true;

					keymaps.diagnostic = {
						"g]" = "goto_next";
						"g[" = "goto_prev";
					};
					servers = {
						clangd.enable = true;
						dockerls.enable = true;
						gopls.enable = true;
						jsonls.enable = true;
						lua-ls.enable = true;
						marksman.enable = true;
						nil-ls.enable = true;
						pyright.enable = true;
						rust-analyzer = {
							enable = true;

							installCargo = true;
							installRustc = true;
						};
						texlab.enable = true;
						tsserver.enable = true;
						yamlls.enable = true;
						zls.enable = true;
					};
				};
				lsp-format.enable = true;
				lualine.enable = true;
				luasnip.enable = true;
				markdown-preview.enable = true;
				noice.enable = true;
				notify.enable = true;
				nvim-autopairs.enable = true;
				nvim-snippets.enable = true;
				rustaceanvim.enable = true;
				surround.enable = true;
				telescope.enable = true;
				tmux-navigator.enable = true;
				todo-comments.enable = true;
				transparent.enable = true;
				treesitter.enable = true;
				twilight.enable = true;
				undotree.enable = true;
				vimtex.enable = true;
				which-key.enable = true;
			};
			keymaps = [ 
			{
				action = "<cmd>make<CR>";
				key = "<C-m>";
				options = {
					silent = true;
					desc = "make";
				};
			}
			{
				action = "<cmd>vertical resize -2<cr>";
				key = "<Left>";
				options = {
					silent = true;
					desc = "";
				};
			}
			{
				action = "<cmd>vertical resize +2<cr>";
				key = "<Right>";
				options = {
					silent = true;
					desc = "";
				};
			}
			{
				action = "<cmd>resize -2<cr>";
				key = "<up>";
				options = {
					silent = true;
					desc = "";
				};
			}
			{
				action = "<cmd>resize +2<cr>";
				key = "<down>";
				options = {
					silent = true;
					desc = "";
				};
			}
			{
				action = "<cmd>tabmove -1<cr>";
				key = "<C-S-PageDown>";
			}
			{
				action = "<cmd>tabmove +1<cr>";
				key = "<C-S-PageUp>";
			}
			{
				action = "vim.cmd.nohlsearch";
				key = "<C-h>";
			}
			{
				action = "<gv";
				key = "<";
				mode = "v";
			}
			{
				action = ">gv";
				key = ">";
				mode = "v";
			}
			{
				action = "<Esc>";
				key = "jj";
				mode = "i";
			}
			];
		};

		programs.neovim = lib.mkIf (config.nixvim.enable == false) {
			enable = true;

			defaultEditor = true;

			extraLuaConfig = lib.fileContents ./init.lua;

			plugins = with pkgs.vimPlugins; [
				nvim-tree-lua
				onedark-nvim
				telescope-nvim
				todo-comments-nvim
				tokyonight-nvim
				vim-commentary
				vim-surround
				which-key-nvim
			];

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
