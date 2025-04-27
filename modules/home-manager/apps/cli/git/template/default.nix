{ ... }:
{
  programs.git.extraConfig.commit.template = "~/.config/git/template";

  home.file.".config/git/template".source = ./template;
}
