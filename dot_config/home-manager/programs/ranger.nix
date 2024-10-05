# Ranger configuration-file
{ config, pkgs, ...}:

{
  programs.ranger.enable = true;
  programs.ranger.plugins = [
    {
      name = "ranger_devicons";
      src = builtins.fetchGit {
        url = "https://github.com/alexanderjeurissen/ranger_devicons.git";
        rev = "a8d626485ca83719e1d8d5e32289cd96a097c861";
      };
    }
    {
      name = "ranger_udisk_menu";
      src = builtins.fetchGit {
        url = "https://github.com/SL-RU/ranger_udisk_menu";
        rev = "c892d447177051dd2fa97e2387b2d04bf8977de7";
      };
    }
  ];
  programs.ranger.settings = {
    preview_images_method = "sixel";
    hostname_in_titlebar = false;
    tilde_in_titlebar = true;
    line_numbers = true;
    preview_script = "~/.config/ranger/scope.sh";
    use_preview_script = true;
    preview_images = true;
    preview_files = false;
  };
  programs.ranger.extraConfig = ''
    setlocal path=~/downloads sort mtime
    setlocal path=~/.local/share/Trash/files sort mtime
    default_linemode devicons
  '';
  programs.ranger.mappings = {
    "<F1>" = "console touch%space";
    n = "shell nvim -c NvimTreeToggle";
    N = "shell -f $TERMINAL -T %d -e nvim -c NvimTreeToggle";
    "<C-t>" = "shell gio trash %f";
    dT = "shell gio trash --restore trash:///%f";
    O = "shell -f md.obsidian.Obsidian @@u %f @@";
    "<A-f>" = "fzf_select";
    "<A-h>" = "dir_history_navigate";
    yi = "shell xclip-copyfile %s";
    di = "shell xclip-cutfile %s";
    pi = "shell xclip-pastefile";
    "<A-g>" = "eval p(fm.thisdir)";
    "<A-e>" = "tmux_split_into_ranger";
    "<A-CR>" = "tmux_split_into_zsh";
    gm = "cd /run/media";
    "<C-u>" = "shell rclone copy %s gdrive:\"$(basename $PWD)\"";
  };
  programs.ranger.rifle = [
    # HTML
    {
      condition =       "ext x?html?, has librewolf, X, flag f";
      command = "librewolf -- \"$@\"";
    } {
      condition =       "ext x?html?, has chromium, X, flag f";
      command = "chromium -- \"$@\"";
    } {
      condition =       "ext x?html?, has brave, X, flag f";
      command = "brave -- \"$@\"";
    } {
      condition =       "ext x?html?, has w3m, terminal";
      command = "w3m \"$@\"";
    }

    # MARKDOWN
    {
      condition =       "ext md, has marktext, X, flag f";
      command = "marktext -- \"$@\"";
    } {
      condition =       "ext md, has ghostwriter, X, flag f";
      command = "ghostwriter -- \"$@\"";
    }

    # TEXT-FILES
    {
      condition =       "mime ^text, !path /home/"; # using sudoedit, when not home dir ${config.home.homeDirectory}
      command = "sudoedit \"$@\"";
    } {
      condition =       "mime ^text, label editor";
      command = "\"\${VISUAL:-$EDITOR}\" -- \"$@\"";
    } {
      condition =       "mime ^text,  label pager";
      command = "\"$PAGER\" -- \"$@\"";
    } {
      condition =       "!mime ^text, label editor, ext xml|json|csv|tex|py|pl|rb|js|sh|php, !path /home/";
      command = "sudoedit \"$@\"";
    } {
      condition =       "!mime ^text, label editor, ext xml|json|csv|tex|py|pl|rb|js|sh|php";
      command = "\"\${VISUAL:-$EDITOR}\" -- \"$@\"";
    } {
      condition =       "!mime ^text, label pager, ext xml|json|csv|tex|py|pl|rb|js|sh|php";
      command = "\"$PAGER\" -- \"$@\"";
    }

    # SQLITE
    {
      condition =       "ext db|sqlite*, has sqlitebrowser, X, flag f";
      command = "sqlitebrowser -- \"$@\"";
    }

    # SCID-DATABASE
    {
      condition =       "ext si5, has flatpak, X, flag f";
      command = "scid -- \"$@\"";
    } {
      condition =       "ext pgn, has flatpak, X, flag f";
      command = "scid -- \"$@\"";
    }

    # WINE
    {
      condition =       "ext exe";
      command = "wine \"$1\"";
    }

    # AUDIO
    {
      condition =       "mime ^audio|ogg$, has rhythmbox, X, flag f";
      command = "rhythmbox -- \"$@\"";
    } {
      condition =       "mime ^audio|ogg$, terminal, has mpv";
      command = "mpv -- \"$@\"";
    }

    # VIDEO/AUDIO
    {
      condition =       "mime ^video|audio, has vlc, X, flag f";
      command = "vlc -- \"$@\"";
    }

    # DOCUMENTS
    {
      condition =       "ext pdf, has sioyek, X, flag f";
      command = "sioyek --new-window \"$@\"";
    } {
      condition =       "ext pdf, has microsoft-edge, X, flag f";
      command = "microsoft-edge -- \"$@\"";
    } {
      condition =       "ext pdf, has okular, X, flag f";
      command = "okular -- \"$@\"";
    } {
      condition =       "ext pdf, has chromium, X, flag f";
      command = "chromium -- \"$@\"";
    } {
      condition =       "ext pdf, has pdfarranger, X, flag f";
      command = "pdfarranger -- \"$@\"";
    } {
      condition =       "ext pptx?|od[dfgpst]|docx?|sxc|xlsx?|xlt|xlw|gnm|gnumeric, has libreoffice, X, flag f";
      command = "libreoffice \"$@\"";
    } {
      condition =       "ext epub, has foliate, X, flag f";
      command = "foliate -- \"$@\"";
    }

    # IMAGES
    {
      condition =       "mime ^image/svg, has inkscape, X, flag f";
      command = "inkscape -- \"$@\"";
    } {
      condition =       "mime ^image, has xviewer, X, flag f";
      command = "xviewer -- \"$@\"";
    } {
      condition =       "mime ^image, has pix, X, flag f";
      command = "pix -- \"$@\"";
    } {
      condition =       "mime ^image, has gimp, X, flag f";
      command = "gimp -- \"$@\"";
    } {
      condition =       "ext xcf, X, flag f";
      command = "gimp -- \"$@\"";
    }

    # ARCHIVES
    {
      condition =       "ext 7z, has 7z, X, flag f";
      command = "7z -p l \"$@\" | \"$PAGER\"";
    } {
      condition =       "ext iso|jar|msi|pkg|rar|shar|tar|tgz|xar|xpi|xz|zip, has file-roller, X, flag f";
      command = "file-roller \"$@\" | \"$PAGER\"";
    } {
      condition =       "ext 7z|ace|ar|arc|bz2?|cab|cpio|cpt|deb|dgc|dmg|gz, has file-roller, X, flag f";
      command = "file-roller \"$@\"";
    } {
      condition =       "ext iso|jar|msi|pkg|rar|shar|tar|tgz|xar|xpi|xz|zip, has file-roller, X, flag f";
      command = "file-roller \"$@\"";
    } {
      condition =       "ext bz2, has bzip2";
      command = "for file in \"$@\"; do bzip2 -dk \"$file\"; done";
    } {
      condition =       "ext zip, has unzip";
      command = "unzip -l \"$1\" | \"$PAGER\"";
    } {
      condition =       "ext zip, has unzip";
      command = "for file in \"$@\"; do unzip -d \"\${file%.*}\" \"$file\"; done";
    } {
      condition =       "ext rar, has unrar";
      command = "unrar l \"$1\" | \"$PAGER\"";
    } {
      condition =       "ext rar, has unrar";
      command = "for file in \"$@\"; do unrar x \"$file\"; done";
    }

    # FONTS
    {
      condition =       "mime ^font, has fontforge, X, flag f";
      command = "fontforge \"$@\"";
    }

    # FALLBACK TERMINAL
    {
      condition =       "mime ^ranger/x-terminal-emulator, has foot";
      command = "foot -e \"$@\"";
    } {
      condition =       "mime ^ranger/x-terminal-emulator, has alacritty";
      command = "alacritty -e \"$@\"";
    }

    # FALLBACK OPENERS
    {
      condition =       "!mime ^text, !ext xml|json|csv|tex|py|pl|rb|js|sh|php, !path /home/";
      command = "sudoedit \"$@\"";
    } {
      condition =       "!mime ^text, !ext xml|json|csv|tex|py|pl|rb|js|sh|php";
      command = "\"\${VISUAL:-$EDITOR}\" -- \"$@\"";
    } {
      condition =       "!mime ^text, !ext xml|json|csv|tex|py|pl|rb|js|sh|php";
      command = "\"$PAGER\" -- \"$@\"";
    } {
      condition =       "mime application/x-executable|text/x-shellscript";
      command = "\"$@\"";
    } {
      condition =       "mime application/x-executable|text/x-shellscript";
      command = "chmod +x \"$1\"";
    } {
      condition =       "mime application/x-executable|text/x-shellscript";
      command = "chmod -x \"$1\"";
    }

    # GENERIC FILE OPENERS
    {
      condition =       "label open, has xdg-open, X, flag f";
      command = "xdg-open -- \"$@\"";
    }

    # (UN)SET EXECUTION PERMISSIONS
    {
      condition =       "ext desktop|appimage";
      command = "chmod +x \"$1\"";
    } {
      condition =       "ext desktop|appimage ";
      command = "chmod -x \"$1\"";
    }
  ];
}
