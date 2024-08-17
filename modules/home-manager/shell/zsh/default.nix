{ lib, config, pkgs, ... }:
let
	historySize = 999999999;
in
{
	options.zsh = {
		enable = lib.mkEnableOption "Enable zsh module";

		enablePowerlevel10k = lib.mkOption {
			description = "Whether to enable the powerlevel10k plugin.";
			type = lib.types.bool;
			default = true;
		};
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
			initExtra = lib.mkMerge [
				(lib.mkIf config.zsh.enablePowerlevel10k "source ${./.p10k.zsh}")
				"${pkgs.fastfetch}/bin/fastfetch"
			];
			localVariables = {
				PS1 = "%F{green}%n%f%F{yellow}@%f%F{red}%m%f %F{cyan}%~%f $ ";
			};
			plugins = [
				(lib.mkIf config.zsh.enablePowerlevel10k {
				 name = "powerlevel10k";
				 src = pkgs.zsh-powerlevel10k;
				 file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
				 })
			];
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
