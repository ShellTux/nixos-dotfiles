{ config, lib, ... }:
{
  imports = [ ./calendar.crypt.nix ];
  accounts.calendar = lib.mkIf config.accounts.calendar.enable {
    basePath = "Calendar";
  };
}
