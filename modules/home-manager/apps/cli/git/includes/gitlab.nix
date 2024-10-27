{ ... }:
{
  programs.git.includes = [
    {
      condition = "gitdir:~/.local/src/gitlab/";
      contents.user = {
        name = "luisgois";
        email = "22894804-luisgois@users.noreply.gitlab.com";
      };
    }
  ];
}
