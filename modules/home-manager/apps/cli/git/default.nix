{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) getExe;
  fshow = import ./fshow.nix { inherit pkgs; };
in
{
  # TODO: Add option to choose between delta, diff-so-fancy, difftastic
  options.apps.cli.git.enable = lib.mkEnableOption "Enable git module";

  imports = [
    ./excludesFiles.nix
    ./includes
  ];

  config = lib.mkIf config.apps.cli.git.enable {
    programs.git = {
      enable = true;
      userName = "ShellTux";
      userEmail = "115948079+ShellTux@users.noreply.github.com";
      extraConfig = {
        branch.sort = "-committerdate";
        column.ui = "auto";
        commit.verbose = true;
        core = {
          editor = "nvim";
          autocrlf = "input";
        };
        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          mnemonicPrefix = true;
          renames = true;
        };
        help.autoCorrect = "prompt";
        init = {
          defaultBranch = "main";
        };
        rerere = {
          enable = true;
          autoupdate = true;
        };
        tag.sort = "version:refname";
      };
      aliases = rec {
        branch-delete = "branch --delete";
        br = "branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate";
        ci = "commit";
        co = "checkout";
        co- = "!git -c interactive.diffFilter='less --tabs=4 -RFX' checkout";
        conflict = "diff --name-only --diff-filter=U";
        cop = "co --patch";
        cop- = "co- --patch";
        cp = "cherry-pick";
        d- = "${d}-";
        dc = "diff-copy";
        d = "diff";
        diff-copy = ''!git diff-staged | ([ "$XDG_SESSION_TYPE" = "x11" ] && ${pkgs.xclip}/bin/xclip -selection clipboard || ${pkgs.wl-clipboard}/bin/wl-copy)'';
        diff- = "!git -c interactive.diffFilter='less --tabs=4 -RFX' diff";
        diff-last = "!git diff HEAD~1 HEAD";
        diff-staged = "diff --staged";
        diff-staged- = "diff- --staged";
        diff-summary = "diff --stat";
        diff-word = "diff --word-diff --color-words";
        dl = "diff-last";
        dst- = "${dst}-";
        dst = "diff-staged";
        dsu = "diff-summary";
        dw = "diff-word";
        forget = "update-index --assume-unchanged";
        graph = "log --graph";
        h = "history";
        history = "!${fshow}/bin/fshow";
        ignore = "!${getExe pkgs.curl} -sL https://www.toptal.com/developers/gitignore/api/$@";
        last = "!git log -1 HEAD";
        lg1 = ''log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all'';
        lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n'' %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
        lg = ''!git log --pretty=format:"%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]" --abbrev-commit -30'';
        open = "visit";
        patch = "!git --no-pager diff --no-color";
        project-summary = "summary";
        put = "push --set-upstream origin";
        serve = "daemon --verbose --export-all --base-path=.git --reuseaddr --strict-paths .git/";
        showconfig = "config --list";
        # FIX: Mismatch between input and output. See this: https://github.com/so-fancy/diff-so-fancy/issues/296
        sp- = "!git -c interactive.diffFilter='less --tabs=4 -RFX' sp";
        sp = "stage --patch";
        s = "status --short";
        stats = "show --stat";
        st = "status";
        summary = "!which ${getExe pkgs.onefetch} && ${getExe pkgs.onefetch}";
        sw = "switch -";
        touch = "!touch $@ && git add $@";
        unstage = "reset HEAD --";
        visit-branch = ''!${pkgs.xdg-utils}/bin/xdg-open "https://`git config --get remote.origin.url | sed -E "s#(git@|git://|https?://|.git$)##g;s#:#/#"`/tree/`git branch --show-current`"'';
        visit = ''!${pkgs.xdg-utils}/bin/xdg-open "https://`git config --get remote.origin.url | sed -E "s#(git@|git://|https?://|.git$)##g;s#:#/#"`"'';
        yolo = ''!git commit --message="$(curl --silent https://whatthecommit.com/index.txt)"'';
      };
      delta = {
        enable = false;

        options = {
          light = false;
          navigate = true;
        };
      };
      diff-so-fancy = {
        enable = true;
      };
    };
  };
}
