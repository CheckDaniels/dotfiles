# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./stylix.nix
      ./kanata.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      daniel = import ./../home.nix;
    };
    backupFileExtension = "backup";
  };


  nix.settings.experimental-features = ["nix-command" "flakes"]; 

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.generic-extlinux-compatible.configurationLimit = 3;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_CH.UTF-8";
    LC_IDENTIFICATION = "de_CH.UTF-8";
    LC_MEASUREMENT = "de_CH.UTF-8";
    LC_MONETARY = "de_CH.UTF-8";
    LC_NAME = "de_CH.UTF-8";
    LC_NUMERIC = "de_CH.UTF-8";
    LC_PAPER = "de_CH.UTF-8";
    LC_TELEPHONE = "de_CH.UTF-8";
    LC_TIME = "de_CH.UTF-8";
  };

  # AUTO-CPUFREQ
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
 
  services.displayManager.sddm = {
      enable = true;
      theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
      wayland.enable = true;
      settings = { 
        Autologin = {
          Session = "hyprland.desktop";
          User = "daniel";
        };
        Theme = {
          CursorTheme = "Nordic-cursors";
        };
      };
  }; 




  # Add PAM module for unlocking the keyring at login
  # security.pam.services.sddm.enableGnomeKeyring = true;

  # Optionally, set the keyring password to your login password
  services.gnome.gnome-keyring.enable = true;

  # enable/install seahorse for managing "passwords and keys"
  programs.seahorse.enable = true;
  
  # knable/install gnupg for git ssh authentication
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  
  security.polkit.enable = true;
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };


  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Configure keymap in X11
    xkb.layout = "custom";    
    xkb.extraLayouts = {
      custom = {
	description = "German (Custom)";	
	languages = [ "ger" ];
	symbolsFile = keyboard-layout/custom_de;
      };
    };

    desktopManager = {
      lxqt.enable = true;
     # cinnamon.enable = true;
    };
  };

  # programs.ydotool.enable = true;


  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.defaultUserShell=pkgs.zsh;
  # enable zsh and oh my zsh
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      autosuggestions.async = true;
      enableCompletion = true;
      zsh-autoenv.enable = true;
      syntaxHighlighting.enable = true; 
    };
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.daniel = {
    isNormalUser = true;
    description = "Daniel Richter";
    extraGroups = [ "networkmanager" "wheel" ]; #ydotool
    packages = with pkgs; [
    #  thunderbird
    ];
  };
  security.sudo.extraRules = [
    {  users = [ "daniel" ];
      commands = [
        { command = "ALL" ;
          options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];

  environment.variables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORMTHEME = lib.mkForce "qt6ct";
    QT_STYLE_OVERRIDE = lib.mkForce "kvantum";
    EDITOR="nvim";
    VISUAL="nvim";
    BROWSER="brave";
    TERMINAL="foot";
  };

  # Install Hyprland.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  # Install Sway
  # programs.sway = {
  #   enable = true;
  #   wrapperFeatures.gtk = true;
  # };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    nerdfonts
    "${import ./fonts/alpha.nix { inherit pkgs; }}"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # activitywatch
    alsa-utils
    arduino
    arena
    aria2
    atuin
    audacity
    auto-cpufreq
    bat
    birdtray
    bitwarden-desktop
    blanket
    blueman
    brave
    brightnessctl
    btop
    catdoc
    cheese
    chezmoi
    chromium
    cmake
    copyq
    debugedit
    direnv
    discord
    drawio
    dust
    epub-thumbnailer
    fastfetch
    fd
    ffmpeg
    ffmpegthumbnailer
    file
    file-roller
    findutils
    focuswriter
    foliate
    # fontforge
    freetube
    fzf
    gdu
    ghostwriter
    gimp
    git
    gitkraken
    glib # for gio trash
    gnome-characters
    gnome-clocks
    gnome-pomodoro
    gnome-disk-utility
    gnome-frog
    gparted
    grim
    gtk2
    gtt
    highlight
    home-manager
    hunspell
    hunspellDicts.de_CH
    hyprshot
    imagemagick
    inkscape
    # iotas
    jetbrains.pycharm-community
    jq
    kanata
    kbd
    kdePackages.qt6ct
    kdePackages.qtstyleplugin-kvantum
    libnotify
    librewolf
    libreoffice-fresh
    librsvg
    libsForQt5.kruler
    libsForQt5.okular
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtwayland
    libsForQt5.qtstyleplugins
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    libsixel
    lxqt.lxqt-policykit
    mako
    marktext
    microsoft-edge
    morgen
    nemo
    networkmanagerapplet
    newsflash
    nextcloud-client
    nixfmt-classic
    nix-prefetch-git
    nordic
    nwg-look
    obsidian
    odt2txt
    oh-my-posh
    onlyoffice-bin
    pandoc
    pamixer
    papirus-nord
    pavucontrol
    pdfarranger
    polkit_gnome
    poppler_utils 
    prismlauncher
    protonmail-bridge
    protonmail-desktop
    protonvpn-gui
    pulseaudio
    python312
    python312Packages.chardet
    python312Packages.docx2txt
    python312Packages.pdf2image
    python312Packages.python-bidi
    python312Packages.tkinter
    qalculate-gtk
    qownnotes
    ranger
    rclone
    rhythmbox
    scid
    signal-desktop
    sioyek
    slurp
    spotify
    sqlite
    sqlitebrowser
    sqlite-utils
    stacer
    stockfish
    super-productivity
    swaybg
    # teams-for-linux
    tk
    tlp
    tmux
    tty-clock
    ueberzugpp
    uget
    # uget-integrator needs to be packaged manually with fetchFromGitHub
    ulauncher
    unrar
    unzip
    virtualbox
    # virtualbox-guest-iso
    vlc
    w3m
    waybar
    wev
    wget
    wineWowPackages.waylandFull
    wl-clipboard
    wl-clipboard-x11
    wofi
    xcape
    xclip
    xdotool
    xed-editor
    xorg.setxkbmap
    xorg.xev
    xorg.xmodmap
    xorg.xset
    xwayland
    zsh-forgit  
  ];
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # installs thunderbird
  programs.thunderbird.enable = true;
  # enables/installs appimage-run
  programs.appimage.enable = true;

  # services.arbtt.enable = true;
  
  # enables flatpak
  services.flatpak.enable = true; 
  systemd.services.flatpak-repo = {
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
    #  other applications to install
  };


  xdg = {
    autostart.enable = true;
    portal.enable = true;
    portal.extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  # system.autoUpgrade = {
  #   enable = true;
  #   allowReboot = true;
  # };  
}
