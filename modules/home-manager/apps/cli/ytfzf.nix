{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.apps.cli.ytfzf;

  settingsFile =
    let
      renderVariables =
        attr:
        lib.mapAttrsToList (
          name: value: if (lib.isString value) then ''${name}="${value}"'' else "${name}=${toString value}"
        ) attr;
      renderFunctions = attr: lib.mapAttrsToList (name: value: ''${name} () {\n${value}\n}'') attr;
    in
    lib.concatStringsSep "\n" (
      (renderVariables cfg.variables) ++ (renderFunctions cfg.functions) ++ [ cfg.extraConfig ]
    );
in
{
  options.apps.cli.ytfzf = {
    enable = lib.mkEnableOption "Enable ytfzf module";

    package = lib.mkPackageOption pkgs "ytfzf" { };

    variables = lib.mkOption {
      type =
        with lib.types;
        attrsOf (oneOf [
          ints.unsigned
          str
          bool
        ]);
      default = {
        show_thumbnails = true;
        thumbnail_viewer = "wayland";
        is_loop = true;
      };
      example = {
        ytdl_pref = "248+bestaudio/best";
        sub_link_count = true;
        show_thumbnails = true;
      };
      description = "The variables for ytfzf.";
    };

    functions = lib.mkOption {
      type = with lib.types; attrsOf nonEmptyStr;
      default = { };
      example = {
        external_menu =
          # sh
          ''
            rofi -dmenu -width 1500 -p "$1"
          '';
        video_player =
          # sh
          ''
            case "$is_detach"
            	0) vlc "$@" ;;
            	1) setsid -f vlc "$@" > /dev/null 2>&1 ;;
            	esac
            		'';
        on_opt_parse_c =
          # sh
          ''
            		arg="$1"
            case "$arg" in
            		SI|S) is_loop=1 ;;
            		esac
            			'';
      };
      description = "The functions for ytfzf.";
    };

    extraConfig = lib.mkOption {
      type = lib.types.str;
      default = "";
      example = "";
      description = "Extra configuration lines to add to ytfzf config.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile."ytfzf/conf.sh".text = lib.mkIf (
      cfg.variables != { } || cfg.functions != { } || cfg.extraConfig != ""
    ) settingsFile;
  };
}
