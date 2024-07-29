{ inputs, config, pkgs, ... }:

{ 
  home.username = "daniel";
  home.homeDirectory = "/home/daniel";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # (pkgs.callPackage ./programs/stockfish.nix {})
  ];

  home.file = {
    # ZSH CONFIGURATION
    ".zshrc".source = programs/zsh/zshrc;
    ".zshrc-personal".source = programs/zsh/zshrc-personal;

    # RANGER
    ".config/ranger/scope.sh".source = programs/ranger/scope.sh;
    ".config/ranger/commands.py".source = programs/ranger/commands.py;
    ".config/ranger/ranger_cd.sh".source = programs/ranger/ranger_cd.sh;


    # Google Translate (and others like DeepL etc. )
    ".config/gtt/server.yml".source = programs/gtt/server.yml;
    ".config/gtt/gtt.yaml".source = programs/gtt/gtt.yaml;
    ".local/share/applications/gtt.desktop".source = programs/gtt/gtt.desktop;
    
    # HYPRLAND (Shellscripts & Images)
    ".config/hypr/wofi".source = desktop/hyprland/wofi;
    ".config/hypr/wofifull".source = desktop/hyprland/wofifull;
    ".config/hypr/wofi-power".source = desktop/hyprland/wofi-power;
    ".config/hypr/scripts".source = desktop/hyprland/scripts;
    ".config/hypr/mako/icons".source = desktop/hyprland/mako-icons;
    ".config/hypr/wallpapers".source = desktop/hyprland/wallpapers;
    ".config/waybar/theme.css".text = ''
      @define-color base00 #${config.colorScheme.colors.base00}; 
      @define-color base01 #${config.colorScheme.colors.base01};
      @define-color base02 #${config.colorScheme.colors.base02};
      @define-color base03 #${config.colorScheme.colors.base03};
      @define-color base04 #${config.colorScheme.colors.base04};
      @define-color base05 #${config.colorScheme.colors.base05};
      @define-color base06 #${config.colorScheme.colors.base06};
      @define-color base07 #${config.colorScheme.colors.base07};
      @define-color base08 #${config.colorScheme.colors.base08};
      @define-color base09 #${config.colorScheme.colors.base09};
      @define-color base0A #${config.colorScheme.colors.base0A};
      @define-color base0B #${config.colorScheme.colors.base0B};
      @define-color base0C #${config.colorScheme.colors.base0C};
      @define-color base0D #${config.colorScheme.colors.base0D};
      @define-color base0E #${config.colorScheme.colors.base0E};
      @define-color base0F #${config.colorScheme.colors.base0F};
    '';

    # APPLICATIONS
    ".local/share/applications" = {
      source = programs/applications/filter;
      recursive = true;
    };
    ".local/share/applications/custom-launcher.desktop".source = programs/applications/custom-launcher.desktop;
    ".local/share/applications/GitKraken Desktop.desktop".source = "${./programs/applications}/GitKraken Desktop.desktop";
    ".local/share/applications/scid.desktop".source = "${./programs/applications}/scid.desktop";
    # ".local/share/ghostwriter/themes/Nord.json".source = programs/applications/ghostwriter/Nord.json;
  };

  home.sessionVariables = {
    
  };
 
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  
  
  
  #########################################
  ### CUSTOM HOME-MANAGER-CONFIGURATION ###
  #########################################

  #–––––––––––––––––––––––#
  # PROGRAM-CONFIGURATION #
  #–––––––––––––––––––––––#

  imports = [ #import configurations of other applications 
    inputs.nix-colors.homeManagerModules.default
    ./programs/alacritty.nix
    ./programs/ranger.nix
    ./programs/tmux.nix
    ./programs/oh-my-posh.nix
    ./programs/nixvim/default.nix

    ./desktop/hyprland.nix
    ./desktop/cinnamon.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.nord;

  # GIT
  programs.git = {
    enable = true;
    userName = "CheckDaniels";
    userEmail = "danield.richter@proton.me";
  };

  # BTOP
  programs.btop = { 
    enable = true;
  };

  # GNOME-TERMINAL
  # programs.gnome-terminal = {
  #   enable = true;
  # };

  # LIBREWOLF
  programs.librewolf = {
    enable = true;
  };
  

  #––––––––––––––––––––––#
  # OTHER-CONFIGURATIONS #
  #––––––––––––––––––––––# 

  
  # THEMES
  gtk = {
    enable = true;
  };
  
  services.xsettingsd = {
    enable = true;
  };

  # MIME-TYPES
  xdg.mimeApps.defaultApplications = {
    "text/*" = ["xed.desktop"];
    "image/*" = [ "xviewer.desktop" ];
    "video/*" = [ "vlc.desktop" ];
    "application/pdf" = [ "sioyek.desktop" ];
    "application/msword" = [ "writer.desktop" ];
    "application/rtf" = [ "writer.desktop" ];
    "application/vnd*" = [ "writer.desktop" ];
    "application/x-abiword" = [ "writer.desktop" ];
  };

  # STARTUP APPLICATIONS

  xdg.configFile."autostart/Ulauncher.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Exec=ulauncher --hide-window
    X-GNOME-Autostart-enabled=true
    NoDisplay=false
    Hidden=false
    Name[en_US]=Ulauncher
    Comment[en_US]=No description
    X-GNOME-Autostart-Delay=0
  '';

  xdg.configFile."autostart/Nextcloud.desktop".text = ''
    [Desktop Entry]
    Name=Nextcloud
    GenericName=File Synchronizer
    Exec=nextcloud --background
    Terminal=false
    Icon=Nextcloud
    Categories=Network
    Type=Application
    StartupNotify=false
    X-GNOME-Autostart-enabled=true
    X-GNOME-Autostart-Delay=10
  ''; 

}
