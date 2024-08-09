{ pkgs, lib, ... }:
{
	nixvim = {
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

	neovim = with pkgs.vimPlugins; [
		nvim-tree-lua
		onedark-nvim
		telescope-nvim
		todo-comments-nvim
		tokyonight-nvim
		vim-commentary
		vim-surround
		which-key-nvim
	];
}
