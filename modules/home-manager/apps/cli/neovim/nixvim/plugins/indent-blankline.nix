{ ... }:
{
	programs.nixvim.plugins.indent-blankline.settings = {
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
		indent.tab_char = "";
	};
}
