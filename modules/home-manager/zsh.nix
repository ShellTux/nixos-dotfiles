{ lib, config, ... }:
let
	historySize = 999999999;
in
{
	options = {
		zsh.enable = lib.mkEnableOption "Enable zsh module";
	};

	config = lib.mkIf config.zsh.enable {
		programs.zsh = {
			enable = true;

			autocd = true;
			autosuggestion.enable = true;
			cdpath = [
				"~"
				"~/.local/src"
				"~/.local/bin"
				"~/.local"
				"/etc"
			];
			defaultKeymap = "emacs";
			dirHashes = {
				docs = "$HOME/Documentos";
			};
			dotDir = ".config/zsh";
			enableCompletion = true;
			history = {
				expireDuplicatesFirst = true;
				ignoreAllDups = true;
# TODO: share with bash
				ignorePatterns = [
					"[bf]g"
					"cd"
					"clear"
					"exit"
					"ls *"
					"shred *"
					"pkill *"
				];
				path = "${config.xdg.dataHome}/zsh/zsh_history";
				save = historySize;
				size = historySize;
			};
			initExtra = ''
			fastfetch
			'';
			localVariables = {
				PS1 = "%F{green}%n%f%F{yellow}@%f%F{red}%m%f %F{cyan}%~%f $ ";
			};
			plugins = [];
			shellGlobalAliases = {
				UUID = "$(uuidgen | tr -d \\n)";
				G = "| grep";
			};
			syntaxHighlighting = {
				enable = true;
				highlighters = [
					"main"
					"brackets"
					"pattern"
					"regexp"
				];
				patterns = {
					"rm -rf *" = "fg=white,bold,bg=red";
				};
				styles = {
					comment = "fg=black,bold";
				};
			};
		};
	};
}
