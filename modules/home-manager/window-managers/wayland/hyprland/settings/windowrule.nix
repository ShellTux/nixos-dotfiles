{ ... }:
let
  float = rule: "float, ${rule}";
  idleinhibit = mode: rule: "idleinhibit ${mode}, ${rule}";
  opaque = rule: "opaque, ${rule}";
  workspace = number: rule: "workspace ${builtins.toString number}, ${rule}";
in
{
  config.wayland.windowManager.hyprland.settings.windowrule = [
    # Floating {{{

    (float "class:confirm")
    (float "class:confirmreset")
    (float "class:dialog")
    (float "class:download")
    (float "class:error")
    (float "class:file_progress")
    (float "class:file-roller")
    (float "class:gcolor3")
    (float "class:Lxappearance")
    (float "class:nannou")
    (float "class:nm-connection-editor")
    (float "class:notification")
    (float "class:OpenGL")
    (float "class:org.kde.polkit-kde-authentication-agent-1")
    (float "class:pavucontrol")
    (float "class:pavucontrol-qt")
    (float "class:qt5ct")
    (float "class:Rofi")
    (float "class:Scratchpad")
    (float "class:splash")
    (float "class:syncthing-gtk")
    (float "class:syncthingtray")
    (float "title:branchdialog")
    (float "title:Confirm to replace files")
    (float "title:^/dev/ttyUSB")
    (float "title:File Operation Progress")
    (float "title:^(Media viewer)$")
    (float "title:Open File")
    (float "title:^(Picture-in-Picture)$")
    (float "title:^(Vídeo em janela flutuante)$")
    (float "title:^(Volume Control)$")
    (float "title:wlogout")
    (float "class:viewnior")
    (float "class:Viewnior")
    (float "class:xdg-desktop-portal-gtk")

    # }}}

    # Opaque {{{

    (opaque "title:^(Vídeo em janela flutuante)$")
    (opaque "class:mpv")

    # }}}

    # Idlle Inhibit {{{

    (idleinhibit "focus" "class:com.stremio.stremio")
    (idleinhibit "focus" "class:Jellyfin Media Player")
    (idleinhibit "focus" "class:mpv")
    (idleinhibit "focus" "class:org.jellyfin.jellyfinmediaplayer")
    (idleinhibit "fullscreen" "class:firefox")
    (idleinhibit "fullscreen" "class:firefox-developer-edition")

    # }}}

    "center, floating:1, class:.*"
    "animation none, class:Rofi"
    "noborder, class:^wofi$"
    "fullscreen, title:wlogout"
    "fullscreen, class:wlogout"
    "move 75 44%, title:^/dev/ttyUSB"
    "move 75 44%, title:^(Volume Control)$"
    "size 600 400, title:^(Volume Control)$"
    "size 800 600, title:^/dev/ttyUSB"
    "size 600 400, class:qt5ct"
    "float, title:^(Floating Window - Show Me The Key)$"
    "size 781 113, title:^(Floating Window - Show Me The Key)$"
    "move 893 35, title:^(Floating Window - Show Me The Key)$"
    "workspace 1, title:^(Floating Window - Show Me The Key)$"
    "pin, title:^(Floating Window - Show Me The Key)$"
    "noanim, class:^ueberzugpp_.*$"

    # Workspace {{{

    (workspace 1 "class:Alacritty")
    (workspace 1 "class:Arduino IDE")
    (workspace 2 "class:firefox")
    (workspace 4 "class:krita")
    (workspace 4 "class:xournalpp")
    (workspace 5 "class:one.alynx.showmethekey")
    (workspace 5 "class:org.keepassxc.KeePassXC")
    (workspace 7 "class:com.obsproject.Studio")
    (workspace 7 "class:com.stremio.stremio")
    (workspace 7 "class:Jellyfin Media Player")
    (workspace 7 "class:org.jellyfin.jellyfinmediaplayer")
    (workspace 8 "class:com-atlauncher-App")
    (workspace 8 "class:lutris")
    (workspace 8 "class:Minecraft")
    (workspace 8 "class:PPSSPPQt")
    (workspace 8 "class:PPSSPPSDL")
    (workspace 8 "class:rpcs3")
    (workspace 8 "class:steam")
    (workspace 8 "class:Steam")
    (workspace 8 "class:SummertimeSaga") # 😉
    (workspace 9 "class:discord")
    (workspace 9 "class:Slack")
    (workspace 9 "class:WebCord")
    (workspace 9 "class:zoom")

    # }}}
  ];
}
