{ lib, config, pkgs, home, ... }:

{
wayland.windowManager.hyprland = {
  enable = true;
  xwayland.enable = true;
  systemd.enable = true;
  # systemd.enableXdgAutostart = true;
};

imports = [
  ./hyprland/hypridle.nix
  ./hyprland/hyprlock.nix
  ./hyprland/mako.nix
  ./hyprland/waybar.nix
];

# HYPRLAND_CONFIGURATION
wayland.windowManager.hyprland.settings = {

  ################
  ### MONITORS ###
  ################

  # Configure your Display resolution, offset, scale and Monitors here, use `hyprctl monitors` to get the info.
  monitor= [
    # Default Screen
    "HDMI-A-1,1920x1080@60,0x0,1" 
    # Screen Sharing
    ",preferred,auto,1"
    # Mirrored display
    # ",preferred,auto,1,mirror,DP-1"
    # ",preferred,auto,1,mirror"
  ];

  #workspace=HDMI-A-1,1
  #monitor=HDMI-A-2,1920x1080@60,1920x0,1
  #workspace=HDMI-A-2,2

  # Example :
  #monitor=eDP-1,1920x1080@60,0x0,1
  #monitor=eDP-1,transform,0
  #monitor=eDP-1,addreserved,10,10,10,10
  #workspace=eDP-1,1


  ###################
  ### MY PROGRAMS ###
  ###################
 
  "$mainMod" = "SUPER";
  "$scriptsDir" = "$HOME/.config/hypr/scripts";
  "$menu" = "$scriptsDir/menu";
  "$fullmenu" = "$scriptsDir/fullmenu";
  "$volume" = "$scriptsDir/volume";
  "$microphone" = "$scriptsDir/microphone";
  "$backlight" = "$scriptsDir/brightness";
  "$colorpicker" = "$scriptsDir/colorpicker";
  "$power" = "$scriptsDir/power";
  "$files" = "$scriptsDir/tmux-ranger";
  "$term" = "$scriptsDir/tmux-zsh";
  "$terminal" = "foot";
  "$screenshot" = "$scriptsDir/screenshot";
  "$clipboard" = "$scriptsDir/toggle-copyq";
  "$browser" = "brave";
  "$editor" = "xed";
  "$fileManager" = "nemo";


  #############################
  ### ENVIRONMENT VARIABLES ###
  #############################

  env = [
    "QT_QPA_PLATFORM, wayland;xcb"
    "GDK_BACKEND, wayland, x11"
    "NIXOS_OZONE_WL, 1"
    "XDG_CURRENT_DESKTOP, Hyprland"
    "XDG_SESSION_DESKTOP, Hyprland" 
    "XDG_SESSION_TYPE, wayland"
    "GDK_BACKEND, wayland"
    "CLUTTER_BACKEND, wayland"
    "SDL_VIDEODRIVER, wayland"
    "HYPRSHOT_DIR, Pictures/Screenshots"
    "MOZ_ENABLE_WAYLAND,1"

    # Theming
    "QT_QPA_PLATFORMTHEME, qt6ct"
    "GTK_THEME, Nordic"
    # "HYPRCURSOR_THEME, MyCursor"
    # "HYPRCURSOR_SIZE, 24"
    
    # ydotool
    # "YDOTOOL_SOCKET, $HOME/.ydotool_socket"

    # QT-STUFF
    "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
    # "QT_AUTO_SCREEN_SCALE_FACTOR, 1"

  ];


  #################
  ### AUTOSTART ###
  #################

  # Autostart necessary processes (like notifications daemons, status bars, etc.)
  # Or execute your favorite apps at launch like this:

  exec-once = [ 
    "lxqt-policykit-agent"
    "waybar" 
    "ulauncher --hide-window --no-window-shadow" 
    "nm-applet" 
    "udiskie" 
    "copyq --start-server" 
    "hypridle"
    "sh $scriptsDir/maximized_win.sh"
    "protonmail-bridge -n"
    "sleep 4; birdtray"
    "sleep 4; $scriptsDir/thunderbirdtray"
    "sleep 2; morgen"
    "sleep 3; nextcloud --background"
    "dbus-update-activation-environment --systemd --all"
    "systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    # "sh ~/bin/rmfakecloud/dist/rmfakecloud-x64"
    # "sudo -b ydotoold --socket-path=\"$HOME/.ydotool_socket\" --socket-own=\"$(id -u):$(id -g)\""
  ];

  #dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
  #systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP



  #####################
  ### LOOK AND FEEL ###
  #####################

  general = { 
    gaps_in = 3;
    gaps_out = 7;
    border_size = 2;


    #one color
    "col.active_border" = lib.mkForce "rgba(${config.colorScheme.palette.base05}ff)";
    "col.inactive_border" = lib.mkForce "rgba(${config.colorScheme.palette.base01}ff)";

    #two colors - gradient
    # "col.active_border" = lib.mkForce "rgb(${config.colorScheme.palette.base05}) rgb(${config.colorScheme.palette.base0C}) 90deg";
    # Set to true enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false; 

    allow_tearing = true;

    layout = "master";
  };


  decoration =  {
    rounding = 4;

    blur = {
        enabled = false;
        # size = 3
        # passes = 1
    };
    # fullscreen_opacity = 0.9

    drop_shadow = false;
    # shadow_range = 4
    # shadow_render_power = 3
    # col.shadow = rgba(1a1a1aee)
  };


  blurls = "waybar";

  
  animations = {
    enabled = true;

    bezier = "myBezier, 0.61, 1, 0.88, 1";

    animation = [ 
      "windows, 1, 3, myBezier" 
      "windowsOut, 0, 6, default, popin 80%"
      "fade, 0, 6, default"
      "border, 0 , 6, default"
      "workspaces, 1, 6, default"
    ];
  };

 
  dwindle = {
    pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = true; # You probably want this
  };

  
  master = {
    new_status = "master";
    mfact = 0.5;
  };

  
  misc = { 
    disable_hyprland_logo = true;
    disable_splash_rendering = true;
    mouse_move_enables_dpms = true;
    vfr = true;
    vrr = 2;
  };

  binds = {
    workspace_back_and_forth = true;
  };

  render = {
    direct_scanout = true;
  };
      

  #############
  ### INPUT ###
  #############

  input = {
    # QWERTZ
    kb_layout = "custom";
    
    follow_mouse = 1;
    numlock_by_default = 0;

    touchpad = {
      natural_scroll = true;
      tap-to-click = true;
      drag_lock = true;
      disable_while_typing = true;
    };
  };

  
  gestures = {
    workspace_swipe = true;
    workspace_swipe_fingers = 3;
  };
  
  device = {
    name = "epic-mouse-v1";
    sensitivity = -0.5;
  };

  cursor = {
    # inactive_timeout = 10
    # enable_hyprcursor = true
    hide_on_key_press = true;
  };



  ####################
  ### KEYBINDINGSS ###
  ####################

  bind = [

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
    # TOGGLE-KEYBINDINGS FOR GAMING #
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

    # ULAUNCHER
    "CTRL, SPACE,exec, ulauncher-toggle"
    # TOGGLE SUPERPRODUCTIVITY
    "ALT, S, exec, xdotool key \"alt+s\""

    #~~~~~~~~~~~~~~~~~~~~#
    # CUSTOM KEYBINDINGS #
    #~~~~~~~~~~~~~~~~~~~~#

    # FREQUENTLY USED KEYBINDINGS
    "$mainMod SHIFT, R, exec, hyprctl reload"
    "$mainMod SHIFT, F, exec, hyprctl dispatch workspaceopt allfloat"
    "$mainMod SHIFT, Space, togglefloating"
    "$mainMod, F, fullscreen"
    "$mainMod, Z, fullscreen, 1"
    "$mainMod, Q, killactive"
    "$mainMod, Return, exec, $term"
    "$mainMod, X, exec, $power"  


    # EXIT HYPRLAND
    "CTRL ALT, escape, exit"
    # RELOAD WAYBAR
    "$mainMod CTRL, W, exec, killall waybar; ~/.config/hypr/scripts/statusbar"
    # MENU
    ", menu, exec, $menu"
    "SHIFT, menu, exec, $fullmenu"
    # HIDE ACTIVE WINDOW
    "$mainMod,D,exec, $scriptsDir/hide_unhide_window h"
    # SHOW HIDE WINDOW
    "$mainMod SHIFT,D,exec, $scriptsDir/hide_unhide_window s"
    # TOGGLE CLIPBOARD (copyq)
    "CTRL ALT, C, exec, $clipboard"
    


    # Mainmod Shortcuts (super_l)
    
    # INTERNET BROWSER (brave)
    "$mainMod, I, exec, $browser"
    # FILE EXPLORER (nemo)
    "$mainMod, E, exec, $files"
    # NEW TMUX-SESSION
    "$mainMod, T, exec, $terminal -T tmux-session -e $scriptsDir/tmux-new-session"
    # IOTAS (quick-notes)
    "$mainMod, N, exec, qownnotes"
    # CALENDAR (morgen)
    "$mainMod, C, exec, morgen"
    # TOGGLE EMAIL-CLIENT (thunderbird)
    "$mainMod, M, exec, $scriptsDir/toggle-thunderbird"
    # CHATGPT
    "$mainMod, A, exec, brave --app=https://chatgpt.com/"
    # OBSDIAN
    "$mainMod, O, exec, obsidian"
    # REMARKABLE-CLOUD
    "$mainMod, R, exec, brave --app=https://my.remarkable.com/myfiles"
    # COPILOT
    "$mainMod, B, exec, microsoft-edge-stable --app=https://www.bing.com/chat"
    # Newsflash
    "$mainMod SHIFT, N, exec, newsflash"
    # PAVUCONTROL
    "$mainMod, V, exec, pavucontrol"
    # AUTO-CPUFREQ
    "$mainMod, minus, exec, $terminal -e sudo auto-cpufreq --force=powersave"
    "$mainMod, numbersign, exec, $terminal -e sudo auto-cpufreq --force=reset"
    "$mainMod, plus, exec, $terminal -e sudo auto-cpufreq --force=performance" 


    # OTHER APPLICATIONS (ctrl+alt)
    "CTRL ALT, S, exec, spotify"
    "CTRL ALT, T, exec, appimage-run ~/.config/appimages/superProductivity-9.0.7.AppImage --no-sandbox"
    "CTRL ALT, F, exec, $fileManager"



    # CHANGE WALLPAPER (variety)
    # bind = ALT, n, exec, $scriptsDir/changeWallpaper
    # bind = ALT, p, exec, $scriptsDir/changeWallpaper
    # bind = ALT, left, exec, $scriptsDir/changeWallpaper
    # bind = ALT, right, exec, $scriptsDir/changeWallpaper



    # "$mainMod SHIFT, M, exec, hyprctl dispatch splitratio -0.1"
    # "$mainMod, M, exec, hyprctl dispatch splitratio 0.1"

    "$mainMod SHIFT, Y, exec, $terminal -a clock -T clock -e tty-clock -c -C 7 -r -s -f \"%A, %B, %d\""
    "$mainMod SHIFT, I, layoutmsg, addmaster"
    "$mainMod, J, layoutmsg, cyclenext"
    "$mainMod, K, layoutmsg, cycleprev"

    "$mainMod CTRL, Return, layoutmsg, swapwithmaster"
    "$mainMod, Space, exec, $scriptsDir/changeLayout"
    "$mainMod, Y, exec, $terminal -a update -T update -e cava" # f to cycle through foreground colors

    # MAINMOD + FUNCTION KEYS
    "$mainMod, F1, exec, $browser"
    "$mainMod, F2, exec, $editor"
    "$mainMod, F3, exec, inkscape"
    "$mainMod, F4, exec, gimp"
    "$mainMod, F5, exec, meld"
    "$mainMod, F6, exec, vlc"
    "$mainMod, F7, exec, virtualbox"
    "$mainMod, F8, exec, $fileManager"
    "$mainMod, F9, exec, lollypop"
    "$mainMod, F10, exec, spotify"

    # SPECIAL KEYS
    ", xf86audioraisevolume, exec, $volume --inc"
    ", xf86audiolowervolume, exec, $volume --dec"
    ", xf86audiomute, exec, $volume --toggle"
    ", xf86audiomicmute, exec, $microphone --toggle"
    ", xf86audioplay, exec, playerctl play-pause"
    ", xf86audionext, exec, playerctl next"
    ", xf86audioprev, exec, playerctl previous"
    ", xf86audiostop, exec, playerctl stop"
    ", xf86monbrightnessup, exec, $backlight --inc"
    ", xf86monbrightnessdown, exec, $backlight --dec"

    # MOVE
    "$mainMod ALT, H, movewindow, l"
    "$mainMod ALT, L, movewindow, r"
    "$mainMod ALT, K, movewindow, u"
    "$mainMod ALT, J, movewindow, d"

    # MOVE FOCUS WITH MAINMOD + ARROW KEYS
    "$mainMod, left, movefocus, l"
    "$mainMod, right, movefocus, r"
    "$mainMod, up, movefocus, u"
    "$mainMod, down, movefocus, d"

    # SPECIAL WORKSPACE
    "$mainMod SHIFT, U, movetoworkspace, special"
    "$mainMod, U, togglespecialworkspace,"
 
    
    # GROUPS
    "$mainMod, G, togglegroup"

    # CYCLE WORKSPACES
    "$mainMod, tab, workspace, m+1"
    "$mainMod SHIFT, tab, workspace, m-1"
    "ALT, tab, workspace, previous"
    "ALT SHIFT, tab, workspace, r+1"

    # COLORPICKER
    "$mainMod, P, exec, $colorpicker"
    "$mainMod SHIFT, P, exec, $term --class hyprpicker --hold -e hyprpicker"
    "$mainMod CTRL, S, exec, $wofi_beats"


    #~~~~~~~~~~~~~~~~~~~~#
    # SCREENSHOT-UTILITY #
    #~~~~~~~~~~~~~~~~~~~~#

    # HYPRSHOT (SCREENSHOT-UTILITY)

    # Screenshot a window
    "$mainMod, PRINT, exec, hyprshot -m window"
    # Screenshot a monitor
    ", PRINT, exec, hyprshot -m output"
    # Screenshot a region
    "$shiftMod, PRINT, exec, hyprshot -m region" 
    
    
    
    


    #~~~~~~~~~~~~~~~~~~~~~~~#
    # WORKSPACE-KEYBINDINGS #
    #~~~~~~~~~~~~~~~~~~~~~~~#

    # WORKSPACE NAVIGATION
    "$mainMod, period, workspace, +1"
    "$mainMod, comma, workspace, -1"
    "$mainMod CTRL, period, movetoworkspace, +1"
    "$mainMod CTRL, comma, movetoworkspace, -1"
    "$mainMod SHIFT, period, movetoworkspacesilent, +1"
    "$mainMod SHIFT, comma, movetoworkspacesilent, -1"
    "$mainMod, l, workspace, e+1"
    "$mainMod, h, workspace, e-1"
    "$mainMod CTRL, l, movetoworkspace, e+1"
    "$mainMod CTRL, h, movetoworkspace, e-1"
    "$mainMod SHIFT, l, movetoworkspacesilent, e+1"
    "$mainMod SHIFT, h, movetoworkspacesilent, e-1"

    # SCROLL THROUGH EXISTING WORKSPACES WITH MAINMOD + SCROLL
    "$mainMod, mouse_down, workspace, +1"
    "$mainMod, mouse_up, workspace, -1"


    # SWITCH WORKSPACES WITH MAINMOD + [0-9]
    "$mainMod, 1, workspace, 1"
    "$mainMod, 2, workspace, 2"
    "$mainMod, 3, workspace, 3"
    "$mainMod, 4, workspace, 4"
    "$mainMod, 5, workspace, 5"
    "$mainMod, 6, workspace, 6"
    "$mainMod, 7, workspace, 7"
    "$mainMod, 8, workspace, 8"
    "$mainMod, 9, workspace, 9"
    "$mainMod, 0, workspace, 10"


  # MOVE ACTIVE WINDOW AND FOLLOW TO WORKSPACE
    "$mainMod CTRL, 1, movetoworkspace, 1"
    "$mainMod CTRL, 2, movetoworkspace, 2"
    "$mainMod CTRL, 3, movetoworkspace, 3"
    "$mainMod CTRL, 4, movetoworkspace, 4"
    "$mainMod CTRL, 5, movetoworkspace, 5"
    "$mainMod CTRL, 6, movetoworkspace, 6"
    "$mainMod CTRL, 7, movetoworkspace, 7"
    "$mainMod CTRL, 8, movetoworkspace, 8"
    "$mainMod CTRL, 9, movetoworkspace, 9"
    "$mainMod CTRL, 0, movetoworkspace, 10"


    # MOVE ACTIVE WINDOW TO A WORKSPACE WITH MAINMOD + SHIFT + [0-9]
    "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
    "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
    "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
    "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
    "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
    "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
    "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
    "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
    "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
    "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
 
  ];

  # bindr = [
  #   "CTRL, Control_L, exec, ydotool key 1:1 1:0"
  # ];

  # Resize
  # binde = [
  #   "$mainMod SHIFT, H, resizeactive,-50 0"
  #   "$mainMod SHIFT, L, resizeactive,50 0"
  #   "$mainMod SHIFT, K, resizeactive,0 -50"
  #   "$mainMod SHIFT, J, resizeactive,0 50"
  # ];

  # Move/resize windows with mainMod + LMB/RMB and dragging
  bindm = [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];

 
    

  ##############################
  ### WINDOWS AND WORKSPACES ###
  ##############################

  
  windowrulev2 = [

    "suppressevent maximize, class:.*" # You'll probably like this.
 
    #~~~~~~~~~~~~~~~~~~~~#
    # CUSTOM WINDOWRULES #
    #~~~~~~~~~~~~~~~~~~~~#

    # EXAMPLE WINDOWRULE V2
    "tile, class:^(Spotify)$"

    # ULAUNCHER
    "stayfocused, class:^(ulauncher)$"
    "pin, class:^(ulauncher)$"
 
    # NEXTCLOUD
    "float, title:^(Nextcloud)$"
    "move 1450 50, title:^(Nextcloud)$"
    "noinitialfocus, title:^(Nextcloud)$"
    "pin, title:^(Nextcloud)$"

    # BITWARDEN
    "float, class:^(Bitwarden)$"
    "pin, class:^(Bitwarden)$"
    "move 1000 50, class:^(Bitwarden)$"
    "size 900 800, class:^(Bitwarden)$"

    # SCID
    "float, title:^(Variations)$"
    "stayfocused, title:^(Variations)$"

    # COPYQ
    "float, class:^(com.github.hluk.copyq)$"
    "pin, class:^(com.github.hluk.copyq)$"
    "stayfocused, class:^(com.github.hluk.copyq)$"
    "move 1110 50, class:^(com.github.hluk.copyq)$"
    "size 800 500, class:^(com.github.hluk.copyq)$"

    # KRULER
    "float, class:^(org.kde.kruler)$"
    "pin, class:^(org.kde.kruler)$"
    "center, class:^(org.kde.kruler)$"
    "size, 550 70 class:^(org.kde.kruler)$"

    # TTY-CLOCK
    "float, class:^(clock)$, title:^(clock)$"
    "pin, class:^(clock)$, title:^(clock)$"
    "size 33% 27%, class:^(clock)$, title:^(clock)$"
    "center, class:^(clock)$, title:^(clock)$"


    #~~~~~~~~~~~~~~~~~~~~~~~~#
    # CUSTOM WORKSPACE-RULES #
    #~~~~~~~~~~~~~~~~~~~~~~~~#

    # TERMINAL  
    "workspace 1, title:^(main-session)$"
    # NEMO
    "workspaces 1, class:^(nemo)$"
    # PDF's
    "workspaces 2, class:^(sioyek)$"
    "workspaces 2, class:^(org.kde.okular)$"
    "workspaces 2, class:^(microsoft-edge)$"
    "workspaces 2, class:^(chromium-browser)$"
    # BRAVE
    "workspaces 3, class:^(Brave-browser)$"
    "workspaces 3, class:^(brave-browser)$"
    "workspaces 3, class:^(librewolf)$"
    "workspaces 3, title:^(my.remarkable.com_/myfiles)$"
    # COPILOT
    "workspaces 4, title:^(www.bing.com_/chat)$" 
    # CHATGPT
    "workspaces 4, title:^(chatgpt.com_/)$"
    # OBSIDIAN
    "workspaces 5, class:^(obsidian)$"
    "workspaces 5, class:^(org.gnome.World.Iotas)$"
    "workspaces 5, class:^(PBE.QOwnNotes)$"
    # SUPERPRODUCTIVITY
    "workspaces 6, class:^(superProductivity)$"
    # MORGEN CALENDAR
    "workspaces 6, class:^(Morgen)$"
    # MAILSPRING
    "workspace 7, class:^(Mailspring)$"
    "workspace 7, class:^(thunderbird)$"
    "workspace 7, class:^(Proton Mail)$"
    # TEAMS
    "workspace 8, class:^(teams-for-linux)$"
    # LICHESS
    "workspace 9, title:^(lichess.org_/)$"
    # SCID
    "workspace 9, class:^(Start.tcl)$"
    "workspace 9, class:^(wlroots)$"
    # CHESSX
    "workspace 9, class:^(chessx)$"
    # MINECRAFT
    "workspace 9, class:^(Minecraft)"


    # windowrulev2 = workspace 4, class:^(Apache Directory Studio)$
    # windowrulev2 = bordercolor rgb(EE4B55) rgb(880808), fullscreen:1
    # windowrulev2 = bordercolor rgb(282737) rgb(1E1D2D), floating:1
    # windowrulev2 = opacity 0.8 0.8, pinned:1
    # windowrulev2 = workspace 10, class:^(Microsoft-edge)$
    # windowrulev2 = workspace 8 silent, class^(Steam)$, title:^(Steam)$
    # windowrulev2 = float,class:^(firefox)$,title:^(Picture-in-Picture)$
  ];

};
wayland.windowManager.hyprland.extraConfig = ''
  bind = $mainMod SHIFT, G, submap, clean
  submap = clean
  bind = $mainMod SHIFT, G, submap, reset
  submap = reset
'';

}
