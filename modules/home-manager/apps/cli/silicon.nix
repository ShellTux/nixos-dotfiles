{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.cli.silicon.enable = lib.mkEnableOption "Enable silicon module";

  config = lib.mkIf config.apps.cli.silicon.enable {
    home = {
      packages = with pkgs; [
        silicon
      ];

      shellAliases.silicon = "silicon --background=#7ACFAA --theme=OneHalfDark --font='JetBrains Mono' --pad-horiz=60 --pad-vert=40 --shadow-blur-radius=10";
    };
  };
}
