{}:
{
	enable = true;

	keymaps = {
		diagnostic = {
			"g]" = "goto_next";
			"g[" = "goto_prev";
			# "g}" = "goto_next error";
			# "g{" = "goto_prev error";
		};
		extra = [
		{
			action = "<CMD>LspStop<Enter>";
			key = "<leader>Lsto";
			options.desc = "Lsp Stop";
		}
		{
			action = "<CMD>LspStart<Enter>";
			key = "<leader>Lsta";
			options.desc = "Lsp Start";
		}
		{
			action = "<CMD>LspRestart<Enter>";
			key = "<leader>Lr";
			options.desc = "Lsp Restart";
		}
		{
			action = "<CMD>LspInfo<Enter>";
			key = "<leader>Li";
			options.desc = "Lsp Info";
		}
		{
			key = "gd";
			action.__raw = "require('telescope.builtin').lsp_definitions";
			options.desc = "[G]oto [D]efinition";
		}
		{
			key = "gr";
			action.__raw = "require('telescope.builtin').lsp_references";
			options.desc = "[G]oto [R]eferences";
		}
		{
			key = "gI";
			action.__raw = "require('telescope.builtin').lsp_implementations";
			options.desc = "[G]oto [I]mplementations";
		}
		{
			key = "<leader>D";
			action.__raw = "require('telescope.builtin').lsp_type_definitions";
			options.desc = "Type [D]efinition";
		}
		{
			key = "<leader>ds";
			action.__raw = "require('telescope.builtin').lsp_document_symbols";
			options.desc = "[D]ocument [S]ymbols";
		}
		{
			key = "<leader>ws";
			action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
			options.desc = "[W]orkspace [S]ymbols";
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
}
