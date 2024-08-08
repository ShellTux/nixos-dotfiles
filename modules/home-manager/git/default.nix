{ lib, config, ... }:
{
	options = {
		git.enable = lib.mkEnableOption "Enable git module";
		# TODO: Add option to choose between delta, diff-so-fancy, difftastic
	};

	config = lib.mkIf config.git.enable {
		programs.git = {
			enable = true;
			userName = "ShellTux";
			userEmail = "115948079+ShellTux@users.noreply.github.com";
			extraConfig = {
				core = {
					editor = "nvim";
					excludesFile = [
						# ./ignore
					];
					autocrlf = "input";
				};
				init = {
					defaultBranch = "main";
				};
			};
			aliases = {
				branch-delete = "branch --delete";
				br = "branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate";
				ci = "commit";
				co = "checkout";
				conflict = "diff --name-only --diff-filter=U";
				cp = "cherry-pick";
				diff-copy = ''!git diff-staged | ([ "$XDG_SESSION_TYPE" = "x11" ] && xclip -selection clipboard || wl-copy)'';
				diff-last = ''!git diff HEAD~1 HEAD'';
				diff-staged = "diff --staged";
				diff-summary = "diff --stat";
				diff-word = "diff --word-diff --color-words";
				forget = "update-index --assume-unchanged";
				graph = "log --graph";
				h = "history";
				history = "!~/.config/git/fshow";
				ignore = ''!curl -sL https://www.toptal.com/developers/gitignore/api/$@'';
				last = ''"!git log -1 HEAD"'';
				lg1 = ''log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all'';
				lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n'' %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
				lg = ''"!git log --pretty=format:\"%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]\" --abbrev-commit -30"'';
				open = "visit";
				patch = "!git --no-pager diff --no-color";
				project-summary = "summary";
				put = "push --set-upstream origin";
				serve = "daemon --verbose --export-all --base-path=.git --reuseaddr --strict-paths .git/";
				showconfig = "config --list";
				s = ''"status --short"'';
				stats = "show --stat";
				st = "status";
				summary = "!which onefetch && onefetch";
				sw = "switch -";
				touch = ''"!touch $@ && git add $@"'';
				unstage = "reset HEAD --";
				visit-branch = ''"!xdg-open \"https://`git config --get remote.origin.url | sed -E \"s#(git@|git://|https?://|.git$)##g;s#:#/#\"`/tree/`git branch --show-current`\""'';
				visit = ''"!xdg-open \"https://`git config --get remote.origin.url | sed -E \"s#(git@|git://|https?://|.git$)##g;s#:#/#\"`\""'';
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
