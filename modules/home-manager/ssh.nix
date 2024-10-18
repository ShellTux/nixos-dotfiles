{ lib, config, secrets, ... }:
{
	options.ssh = {
		enable = lib.mkEnableOption "Enable ssh module";

		enableSshAgent = lib.mkOption {
			description = "Whether to enable ssh agent.";
			type = lib.types.bool;
			default = true;
		};
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
				"git.dei.uc.pt" = {
					user = "git";
					identityFile = [ secrets."Ssh/Git.Dei/Private-key".path ];
				};
			};
		};

		services.ssh-agent.enable = config.ssh.enableSshAgent;
	};
}
