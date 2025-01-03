{
  lib,
  config,
  ...
}:
{
  options.apps.cli.gdb.enable = lib.mkEnableOption "Enable gdb module";

  config = lib.mkIf config.apps.cli.gdb.enable {
    xdg.configFile."gdb/gdbinit".source = ./gdbinit;
  };
}
