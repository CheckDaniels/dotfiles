# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./stylix.nix
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

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Configure keymap in X11
    xkb.layout = "custom";    
    xkb.extraLayouts = {
      custom = {
	description = "German (Custom)";	
	languages = [ "ger" ];
	symbolsFile = /etc/nixos/keyboard-layout/custom_de;
      };
    };

    desktopManager = {
      cinnamon.enable = true;
    };
  };

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
    extraGroups = [ "networkmanager" "wheel" ];
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
  };

  # Install Hyprland.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    nerdfonts
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    alsa-utils
    arduino
    aria2
    atuin
    audacity
    auto-cpufreq
    autoPatchelfHook
    bat
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
    # evince 
    # eyedropper
    fd
    ffmpeg
    ffmpegthumbnailer
    file
    file-roller
    findutils
    focuswriter
    foliate
    fontforge
    freetube
    fzf
    gdu
    ghostwriter
    gimp
    git
    gitkraken
    gittyup
    # eog
    gnome.gnome-characters
    gnome-pomodoro
    gnome-disk-utility
    gnome-frog
    gnome-keyring
    gnome-terminal
    # gnome-text-editor
    gparted
    grim
    gtk2
    gtt
    highlight
    home-manager
    hunspell
    hyprshot
    imagemagick
    inkscape
    iotas
    jetbrains.pycharm-community
    jq
    kdePackages.qt6ct
    kdePackages.qtstyleplugin-kvantum
    libnotify
    librewolf
    libreoffice-fresh
    librsvg
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    mailspring
    mako
    marktext
    microsoft-edge
    minecraft
    morgen
    neofetch
    nixfmt-classic
    newsflash
    nextcloud-client
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
    # picom
    poppler_utils 
    protonmail-bridge
    pulseaudio
    # python3
    python312
    python312Packages.chardet
    python312Packages.docx2txt
    python312Packages.pdf2image
    python312Packages.python-bidi
    qalculate-gtk
    # qownnotes
    ranger
    rhythmbox
    scid
    seahorse
    signal-desktop
    sioyek
    slurp
    spotify
    sqlite
    sqlitebrowser
    sqlite-utils
    stacer
    steam
    super-productivity
    swaybg
    teams-for-linux
    tk
    tlp
    tmux
    tty-clock
    ueberzugpp
    uget
    # uget-integrator
    ulauncher
    unrar
    unzip
    # variety
    virtualbox
    # virtualbox-guest-iso
    vlc
    w3m
    waybar
    wget
    whatsapp-for-linux
    wineWowPackages.waylandFull
    wl-clipboard
    wofi
    xclip
    xdotool
    xed-editor
    zsh-forgit
  ];


  # enables flatpak
  services.flatpak.enable = true; 

  xdg = {
    autostart.enable = true;
    portal.enable = true;
    portal.extraPortals = [ 
      pkgs.xdg-desktop-portal
      # pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
