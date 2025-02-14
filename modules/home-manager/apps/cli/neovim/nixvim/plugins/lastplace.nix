{ ... }:
{
  programs.nixvim.plugins.lastplace = {
    settings = {
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
  };
}
