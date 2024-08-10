{}:
{
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
}
