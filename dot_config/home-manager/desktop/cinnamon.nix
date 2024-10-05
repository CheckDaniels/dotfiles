{ config, pkgs, ...}:

{
  # CINNAMON-SETTINGS
  dconf.settings = {
    # general
    "org/cinnamon" = {
      favorite-apps = [ "cinnamon-settings.desktop" "foot.desktop" "brave-browser.desktop" "nemo.desktop" ];
    };
  
    # theme-settings
    "org/cinnamon/desktop/interface" = {
      gtk-theme = "Nordic";
      cursor-theme = "Nordic-cursors";
      icon-theme = "Nordic-bluish";
    };

    "org/cinnamon/theme" = {
      name = "Nordic";
    };

    # hotkeys
    "org/cinnamon/desktop/keybindings/wm" = {
      close = [ "<Alt>F4" "<Super>q" ];
      toggle-maximized = [ "<Super>z" ];
    };

    "org/cinnamon/desktop/keybindings/media-keys" = {
      home = [ "<Super>e" "XF86Explorer" ];
      terminal = [ "<Primary><Alt>t" "<Super>Return" ];
      www = [ "XF86WWW" "<Super>i" ]; 
    };

    "org/cinnamon/desktop/keybindings/custom-keybindings/custom0" = {
      binding = [ "<Primary>space" ];
      command = "ulauncher-toggle";
      name = "Ulauncher";
    };

    # defaul applications
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "foot";
    };
    "org/cinnamon/desktop/applications/calculator" = {
      exec = "qalculate-gtk";
    }; 
    
  };
}
