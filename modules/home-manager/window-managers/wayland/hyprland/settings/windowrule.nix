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

    (float "confirm")
    (float "confirmreset")
    (float "dialog")
    (float "download")
    (float "error")
    (float "file_progress")
    (float "file-roller")
    (float "gcolor3")
    (float "Lxappearance")
    (float "nannou")
    (float "nm-connection-editor")
    (float "notification")
    (float "OpenGL")
    (float "org.kde.polkit-kde-authentication-agent-1")
    (float "pavucontrol")
    (float "pavucontrol-qt")
    (float "qt5ct")
    (float "Rofi")
    (float "Scratchpad")
    (float "splash")
    (float "syncthing-gtk")
    (float "syncthingtray")
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
    (float "viewnior")
    (float "Viewnior")
    (float "xdg-desktop-portal-gtk")

    # }}}

    # Opaque {{{

    (opaque "title:^(Vídeo em janela flutuante)$")
    (opaque "mpv")

    # }}}

    # Idlle Inhibit {{{

    (idleinhibit "focus" "com.stremio.stremio")
    (idleinhibit "focus" "Jellyfin Media Player")
    (idleinhibit "focus" "mpv")
    (idleinhibit "focus" "org.jellyfin.jellyfinmediaplayer")
    (idleinhibit "fullscreen" "firefox")
    (idleinhibit "fullscreen" "firefox-developer-edition")

    # }}}

    "center, floating:1, .*"
    "animation none,Rofi"
    "noborder, ^wofi$"
    "fullscreen, title:wlogout"
    "fullscreen, wlogout"
    "move 75 44%, title:^/dev/ttyUSB"
    "move 75 44%, title:^(Volume Control)$"
    "size 600 400, title:^(Volume Control)$"
    "size 800 600, title:^/dev/ttyUSB"
    "size 600 400, qt5ct"
    "float, title:^(Floating Window - Show Me The Key)$"
    "size 781 113, title:^(Floating Window - Show Me The Key)$"
    "move 893 35, title:^(Floating Window - Show Me The Key)$"
    "workspace 1, title:^(Floating Window - Show Me The Key)$"
    "pin, title:^(Floating Window - Show Me The Key)$"
    "noanim, ^ueberzugpp_.*$"

    # Workspace {{{

    (workspace 1 "Alacritty")
    (workspace 1 "Arduino IDE")
    (workspace 2 "firefox")
    (workspace 4 "krita")
    (workspace 4 "xournalpp")
    (workspace 5 "one.alynx.showmethekey")
    (workspace 5 "org.keepassxc.KeePassXC")
    (workspace 7 "com.obsproject.Studio")
    (workspace 7 "com.stremio.stremio")
    (workspace 7 "Jellyfin Media Player")
    (workspace 7 "org.jellyfin.jellyfinmediaplayer")
    (workspace 8 "com-atlauncher-App")
    (workspace 8 "lutris")
    (workspace 8 "Minecraft")
    (workspace 8 "PPSSPPQt")
    (workspace 8 "PPSSPPSDL")
    (workspace 8 "rpcs3")
    (workspace 8 "steam")
    (workspace 8 "Steam")
    (workspace 8 "SummertimeSaga") # 😉
    (workspace 9 "discord")
    (workspace 9 "Slack")
    (workspace 9 "WebCord")
    (workspace 9 "zoom")

    # }}}
  ];
}
