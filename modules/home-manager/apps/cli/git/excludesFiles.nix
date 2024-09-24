{ ... }:
{
	programs.git.extraConfig.core.excludesFile = [
		"~/.config/git/ignore"
	];

	home.file.".config/git/ignore".source = ./ignore;
}
