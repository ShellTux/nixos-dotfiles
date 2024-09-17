{ lib, config, secrets, ... }:
let
	inherit (config.home) homeDirectory;
	sshDir = "${homeDirectory}/.ssh";
in
{
	options = {
		ssh.enable = lib.mkEnableOption "Enable ssh module";
	};

	config = lib.mkIf config.ssh.enable {
		programs.ssh = {
			enable = true;

			addKeysToAgent = "yes";
			compression = true;
			matchBlocks = {
				"github.com" = {
					user = "git";
					identityFile = [ secrets."Ssh/Github/Private-key".path ];
				};
				"gitlab.com" = {
					user = "git";
					identityFile = [ secrets."Ssh/Gitlab/Private-key".path ];
				};
			};
		};
	};
}
