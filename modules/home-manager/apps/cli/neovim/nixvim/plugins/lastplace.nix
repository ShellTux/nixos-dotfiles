{ ... }:
{
  programs.nixvim.plugins.lastplace = {
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
}
