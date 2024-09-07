{ pkgs, settings, ... }:
let
	keys = [ ];
	username = settings.user.username;
in
{
	users = {
		motd = "";
		users = {
			"${username}" = {
				isNormalUser = true;
				home = "/home/${username}";
				initialPassword = "123456";
				extraGroups = [
					"audio"
					"wheel"
					"networkmanager"
				];
				shell = pkgs.zsh;
				uid = 1000;
				openssh.authorizedKeys.keys = keys;
			};
			root.openssh.authorizedKeys.keys = keys;
		};
	};
}
