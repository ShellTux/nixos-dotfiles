{ ... }:
{
	programs.nixvim.plugins.lsp = {
		keymaps = let
			cmd = command: "<CMD>${command}<ENTER>";
			cmdLua = command: (cmd "lua ${command}");
		in {
			diagnostic = {
				"g]" = "goto_next";
				"g[" = "goto_prev";
			};

			extra = [
			{
				action = cmd "LspStop";
				key = "<leader>Lsto";
				options.desc = "Lsp Stop";
			}
			{
				action = cmd "LspStart";
				key = "<leader>Lsta";
				options.desc = "Lsp Start";
			}
			{
				action = cmd "LspRestart";
				key = "<leader>Lr";
				options.desc = "Lsp Restart";
			}
			{
				action = cmd "LspInfo";
				key = "<leader>Li";
				options.desc = "Lsp Info";
			}
			{
				action.__raw = "require('telescope.builtin').lsp_definitions";
				key = "gd";
				options.desc = "[G]oto [D]efinition";
			}
			{
				action.__raw = "require('telescope.builtin').lsp_references";
				key = "gr";
				options.desc = "[G]oto [R]eferences";
			}
			{
				action.__raw = "require('telescope.builtin').lsp_implementations";
				key = "gI";
				options.desc = "[G]oto [I]mplementations";
			}
			{
				action.__raw = "require('telescope.builtin').lsp_type_definitions";
				key = "<leader>D";
				options.desc = "Type [D]efinition";
			}
			{
				action.__raw = "require('telescope.builtin').lsp_document_symbols";
				key = "<leader>ds";
				options.desc = "[D]ocument [S]ymbols";
			}
			{
				action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
				key = "<leader>ws";
				options.desc = "[W]orkspace [S]ymbols";
			}
			{
				action = cmdLua "vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })";
				key = "g}";
				options.desc = "[G]oto next error";
			}
			{
				action = cmdLua "vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })";
				key = "g{";
				options.desc = "[G]oto previous error";
			}
			];

			lspBuf = {
				gd = {
					action = "definition";
					desc = "[G]oto [D]efinition";
				};
				"<leader>rn" = {
					action = "rename";
					desc = "[R]e[n]ame Symbol";
				};
				"<leader>ca" = {
					action = "code_action";
					desc = "[C]ode [A]ction";
				};
				K = "hover";
				gD = {
					action = "declaration";
					desc = "[G]oto [D]eclaration";
				};
			};
		};
		servers = {
			bashls.enable = true;
			clangd.enable = true;
			dockerls.enable = true;
			gopls.enable = true;
			jsonls.enable = true;
			lua_ls.enable = true;
			marksman.enable = true;
			nil_ls = { enable = true; settings.nix.flake.autoArchive = true; };
			pyright.enable = true;
			rust_analyzer = { enable = true; installCargo = true; installRustc = true; };
			texlab.enable = true;
			ts_ls.enable = true;
			yamlls.enable = true;
			zls.enable = true;
		};
	};
}
