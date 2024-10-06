{ ... }:
{
	programs.aerc = {
		stylesets = {
			catppuccin-mocha = builtins.readFile ./catppuccin-mocha;
		};

		extraConfig.ui.styleset-name = "catppuccin-mocha";
	};
}
