{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.apps.cli.ncmpcpp = {
    enable = lib.mkEnableOption "Enable mpd module";

    visualizerSupport = lib.mkOption {
      description = "Whether to enable visualizer support on ncmpcpp.";
      type = lib.types.bool;
      default = true;
    };
    clockSupport = lib.mkOption {
      description = "Whether to enable clock support on ncmpcpp.";
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.apps.cli.ncmpcpp.enable {
    programs.ncmpcpp = {
      enable = true;

      package = pkgs.ncmpcpp.override {
        visualizerSupport = config.apps.cli.ncmpcpp.visualizerSupport;
        clockSupport = config.apps.cli.ncmpcpp.clockSupport;
      };

      settings = {
        autocenter_mode = "yes";
        follow_now_playing_lyrics = "yes";
        ignore_leading_the = "yes";
        ignore_diacritics = "yes";
        default_place_to_search_in = "database";
        lyrics_directory = "${config.services.mpd.musicDirectory}/.lyrics";

        ## Display Modes ##
        playlist_editor_display_mode = "columns";
        search_engine_display_mode = "columns";
        browser_display_mode = "columns";
        playlist_display_mode = "columns";

        ## General Colors ##
        colors_enabled = "yes";
        main_window_color = "white";
        header_window_color = "cyan";
        volume_color = "green";
        statusbar_color = "white";
        progressbar_color = "cyan";
        progressbar_elapsed_color = "white";

        ## Song List ##
        song_columns_list_format = "(10)[blue]{l} (30)[green]{t} (40)[yellow]{b} (30)[magenta]{a}";
        song_list_format = "{$7%a - $9}{$5%t$9}|{$5%f$9}$R{$6%b $9}{$3%l$9}";

        ## Song List Ueberzug ##
        # song_columns_list_format = "(5)[blue]{l} (20)[green]{t} (25)[yellow]{b} (20)[magenta]{a}";
        # song_list_format = "$6{%a »$4 %t$/r$R}|{%f}";

        ## Current Item ##
        current_item_prefix = "$(blue)$r";
        current_item_suffix = "$/r$(end)";
        current_item_inactive_column_prefix = "$(cyan)$r";

        ## Media Library ##
        media_library_primary_tag = "album_artist";

        ## Alternative Interface ##
        user_interface = "alternative";
        alternative_header_first_line_format = "$0$aqqu$/a {$6%a$9 - }{$3%t$9}|{$3%f$9} $0$atqq$/a$9";
        alternative_header_second_line_format = "{{$4%b$9}{ [$8%y$9]}}|{$4%D$9}";

        ## Classic Interface ##
        song_status_format = " $6%a $7⟫⟫ $3%t $7⟫⟫ $4%b ";

        ## Visualizer ##
        visualizer_data_source = lib.mkIf config.apps.cli.ncmpcpp.visualizerSupport "/tmp/mpd.fifo";
        visualizer_output_name = lib.mkIf config.apps.cli.ncmpcpp.visualizerSupport "my_fifo";
        visualizer_type = lib.mkIf config.apps.cli.ncmpcpp.visualizerSupport "spectrum";
        visualizer_in_stereo = lib.mkIf config.apps.cli.ncmpcpp.visualizerSupport "yes";
        visualizer_look = lib.mkIf config.apps.cli.ncmpcpp.visualizerSupport "◆▋";

        ## Navigation ##
        cyclic_scrolling = "yes";
        header_text_scrolling = "yes";
        jump_to_now_playing_song_at_start = "yes";
        lines_scrolled = "2";

        ## Other ##
        system_encoding = "utf-8";
        regular_expressions = "extended";

        ## Selected tracks ##
        selected_item_prefix = "* ";
        discard_colors_if_item_is_selected = "yes";

        ## Seeking ##
        incremental_seeking = "yes";
        seek_time = "1";

        ## Visibility ##
        header_visibility = "yes";
        statusbar_visibility = "yes";
        titles_visibility = "yes";

        ## Progress Bar ##
        progressbar_look = "=>-";

        ## Now Playing ##
        now_playing_prefix = "> ";
        centered_cursor = "yes";

        # Misc
        display_bitrate = "yes";
        enable_window_title = "yes";
        empty_tag_marker = "";
      };
    };
  };
}
