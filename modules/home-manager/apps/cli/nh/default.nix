{ lib, config, ... }:
{
  options.apps.cli.nh.enable = lib.mkEnableOption "Enable nh module";

  config = lib.mkIf config.apps.cli.nh.enable {
    programs.nh = {
      enable = true;

      clean = {
        enable = true;
        extraArgs = "--keep 5 --keep-since 3d";
      };
    };

    programs.zsh =
      let
        inherit (lib) getExe;

        nh = getExe config.programs.nh.package;
      in
      {
        initExtra = ''
          eval "$(${nh} completions --shell zsh)"
        '';
      };
  };
}
