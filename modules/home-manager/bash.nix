{ pkgs, lib, config, inputs, ... }:
{
	options = {
		bash.enable = lib.mkEnableOption "Enable bash module";
	};

	config = lib.mkIf config.bash.enable {
		programs.bash = {
			enable = true;

			enableCompletion = true;
			historyControl = [
				# "erasedups"
				"ignoredups"
				"ignorespace"
			];
			historyFileSize = 100000;
			historyIgnore = [
				"[bf]g"
				"cd"
				"clear"
				"exit"
				"ls"
				"shred"
				"[ t\]*"
			];
			bashrcExtra = ''
			# help() {
			# 	"$@" --help 2>&1 | bathelp
			# }
			'';
			sessionVariables = {
				CDPATH = ''.:$HOME:${config.xdg.configHome}:$HOME/.local/src:$HOME/.local'';
				PS1 = ''┌──\[\e[0m\]\[\e[1m\][ \[\e[0;1;38;5;48m\]\u\[\e[0;1;1;38;5;226m\]@\[\e[0;1;38;5;196m\]\h\[\e[0;1m\] \`if [ \$(stat --format %u .) = 0 ]; then printf 🔐; fi\` \w ]\[\e[0m\]\[\e[0;3;96m\]\$(git branch --show-current 2>/dev/null | sed 's/^/ (/;s/$/)/;') \[\e[0m\]( \`if [ \$? = 0 ]; then printf '\[\e[0;1;38;5;48m\]✓'; else printf '\[\e[0;1;38;5;196m\]✕'; fi\`\[\e[0m\] )\n└──   \[\e[0;1;38;5;50m\]$ \[\e[0m\]'';
			};
			shellOptions = [
				"histappend"
				"checkwinsize"
				"extglob"
				"globstar"
				"checkjobs"
				"autocd"
			];
			initExtra = ''
			fastfetch
			'';
		};
	};
}
