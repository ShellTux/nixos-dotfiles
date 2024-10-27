{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.locate = {
    enable = lib.mkEnableOption "Enable locate module";

    pruneNixStore = lib.mkOption {
      description = "Wether to prune /nix/store path.";
      type = lib.types.bool;
      default = true;
    };

    extraPrunePaths = lib.mkOption {
      description = "Extra paths to prune from locate.";
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config = lib.mkIf config.locate.enable {
    services.locate = {
      enable = true;
      package = pkgs.plocate;
      localuser = null;
      prunePaths = [
        "/tmp"
        "/var/tmp"
        "/var/cache"
        "/var/lock"
        "/var/run"
        "/var/spool"
        (lib.mkIf config.locate.pruneNixStore "/nix/store")
        "/nix/var/log/nix"
      ] ++ config.locate.extraPrunePaths;
    };
  };
}
