{ lib, config, ... }:

{
programs.waybar.enable = true;
programs.waybar.style = lib.mkForce ./waybar/style-nord.css;
programs.waybar.settings = [{
  layer = "top";
  exclusive = true;
  passthrough = false;
  position = "top";
  spacing = 2;
  fixed-center = true;
  ipc = true;
  margin-left = 6;
  margin-right = 6;
  margin-bottom = 2;

  modules-left = [
    "custom/menu"
    "custom/changewaybar"
    "custom/changewaybarcss"
    "hyprland/workspaces#4"
    #temperature 
    "memory"
    #disk
    "cpu"
  ];
      
  modules-center = [ "clock" ];
      
  modules-right = [
    #network;
    #bluetooth;
    #"custom/weather";
    "custom/maximized"
    "battery"
    #"custom/updater"
    #"custom/keyboard"
    #backlight
    #pulseaudio
    #wireplumber
    #"pulseaudio#microphone"
    #keyboard-state
    "mpris"
    "tray"
    "custom/power"
  ];
  # HYPRLAND WORKSPACES. CHOOSE as desired and place on waybar configs
  # CIRCLES Style
  "hyprland/workspaces" = {
      active-only = false;
      all-outputs = true;
      format = "{icon}";
      show-special = false;
      on-click = "activate";
      on-scroll-up = "hyprctl dispatch workspace e+1";
      on-scroll-down = "hyprctl dispatch workspace e-1";
      persistent-workspaces = {
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
        "5" = [];
      };
      format-icons = {
        active = "";
        inactive = "";
        default = "";
          };
  };

  "custom/maximized" = {
    exec = "cat /tmp/waybar_fullscreen_status";
    interval = 1;
    return-type = "json";
    tooltip = false;
    format = "{}";
  };

  "custom/power" = {
    format = "⏻ ";
    on-click = "sh ~/.config/hypr/scripts/power";
    on-click-right = "sh ~/.config/hypr/scripts/power";
    tooltip = false;
  };

  # ROMAN Numerals style
  "hyprland/workspaces#roman" = {
      active-only = false;
      all-outputs = true;
      format = "{icon}";
      show-special = false;
      on-click = "activate";
      on-scroll-up = "hyprctl dispatch workspace e+1";
      on-scroll-down = "hyprctl dispatch workspace e-1";
      persistent-workspaces = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
      };
      format-icons = {
        "1" = "I";
        "2" = "II";
        "3" = "III";
        "4" = "IV";
        "5" = "V";
        "6" = "VI";
        "7" = "VII";
        "8" = "VIII";
        "9" = "IX";
        "10" = "X";
        
      };
  };

  # PACMAN Style
    "hyprland/workspaces#pacman" = {
      active-only = false;
      all-outputs = true;
      format = "{icon}";
      on-click = "activate";
      on-scroll-up = "hyprctl dispatch workspace e+1";
      on-scroll-down = "hyprctl dispatch workspace e-1";
      show-special = false;
      persistent-workspaces ={
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
      };
      # format = "{icon}";
      format-icons = {
        active = " 󰮯 ";
        default = "󰊠";
        persistent ="󰊠";
      };
  };
    
  "hyprland/workspaces#kanji" = {
      disable-scroll = true;
      all-outputs = true;
      format = "{icon}";
      persistent-workspaces = {
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
        "5" = [];
        };
      format-icons = {
        "1" = "一";
        "2" = "二";
        "3" = "三";
        "4" = "四";
        "5" = "五";
        "6" = "六";
        "7" = "七";
        "8" = "八";
        "9" = "九";
        "10" = "十";
      };
  };
    
  #  NUMBERS and ICONS style
  "hyprland/workspaces#4" = {
      # format = "{name}";
      format = "{name} {icon}";
      #format = " {icon} ";
      show-special = false;
      on-click = "activate";
      on-scroll-up = "hyprctl dispatch workspace e+1";
      on-scroll-down = "hyprctl dispatch workspace e-1";
      all-outputs = true;
      sort-by-number = true;
      format-icons = {
        "1" = "";
        "2" = "";
        "3" = "";
        "4" = "";
        "5" = "󰸗";
        "6" = "󰇮";
        "7" = "󰊻";
        "8" = "";
        "9" = "";
        "10" = 10;
        focused = "";
        default = "";
      };
  };
   
  # GROUP
    
  "group/motherboard" = {
      orientation = "horizontal";
      modules = [
        "cpu"
        "memory"
        "temperature"
        "disk"
      ];	
  };
    
  "group/laptop" = {
      orientation = "horizontal";
      modules = [
        "backlight"
        "battery"
      ];	
  };
    
  "group/audio" = {
      orientation = "horizontal";
      modules = [
        "pulseaudio"
        "pulseaudio#microphone"
      ];	
  };
   
  backlight = {
      interval = 2;
      align = 0;
      rotate = 0;
      #format = "{icon} {percent}%";
      format-icons = [ " " " " " " "󰃝 " "󰃞 " "󰃟 " "󰃠 " ];
      format = "{icon}";
      #format-icons = ["" "" "" "" "" "" "" "" "" "" "" "" "" "" ""];
      tooltip-format = "backlight {percent}%";
      icon-size = 10;
      # on-click = ;
      # on-click-middle = ;
      # on-click-right = ;
      # on-update = ;
      on-scroll-up = "~/.config/hypr/scripts/Brightness.sh --inc";
      on-scroll-down = "~/.config/hypr/scripts/Brightness.sh --dec";
      smooth-scrolling-threshold = 1;
  };
        
  battery = {
      interval = 5;
      align = 0;
      rotate = 0;
      #bat = BAT1;
      #adapter = ACAD;
      full-at = 100;
      design-capacity = false;
      states = {
        good = 95;
        warning = 50;
        critical = 45;
      };
      format = "{icon} {capacity}%";
      format-charging = " {capacity}%";
      format-plugged = "󱘖 {capacity}%";
      format-alt-click = "click";
      format-full = "{icon} Full";
      format-alt = "{icon} {time}";
      format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
      format-time = "{H}h {M}min";
      tooltip = true;
      tooltip-format = "{timeTo} {power}w";
      on-click-middle = "~/.config/hypr/scripts/ChangeBlur.sh";
      on-click-right = "~/.config/hypr/scripts/Wlogout.sh";
  };
        
  bluetooth = {
      format = "";
      format-disabled = "󰂳";
      format-connected = "󰂱 {num_connections}";
      tooltip-format = " {device_alias}";
      tooltip-format-connected = "{device_enumerate}";
      tooltip-format-enumerate-connected = " {device_alias} 󰂄{device_battery_percentage}%";
      tooltip = true;
      on-click = "blueman-manager";
  };
       
  clock = {
      interval = 1;
      # format = " {:%I:%M %p}"; # AM PM format
      format = " {:%H:%M:%S}";
      format-alt = " {:%H:%M   %Y, %d %B, %A}";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      on-click-right = "morgen";
      calendar = {
        mode           = "year";
        mode-mon-col   = 3;
        weeks-pos      = "right";
        on-scroll      = 1;
        format = {
          months = "<span color='#${config.colorScheme.palette.base05}'><b>{}</b></span>";
          days = "<span color='#${config.colorScheme.palette.base03}'><b>{}</b></span>";
          weeks = "<span color='#${config.colorScheme.palette.base05}'><b>W{}</b></span>";
          weekdays = "<span color='#${config.colorScheme.palette.base07}'><b>{}</b></span>";
          today = "<span color='#${config.colorScheme.palette.base08}'><b><u>{}</u></b></span>";
        };
      };
  };

  actions =  {
    on-click-right = "mode";
    on-click-forward = "tz_up";
    on-click-backward = "tz_down";
    on-scroll-up = "shift_up";
    on-scroll-down = "shift_dow";
  };
     
  cpu = {
      format = "{usage}% 󰍛";
      interval = 1;
      format-alt-click = "click";
      format-alt = "{icon0}{icon1}{icon2}{icon3} {usage:>2}% 󰍛";
      format-icons = ["▁"  "▂"  "▃"  "▄"  "▅"  "▆"  "▇"  "█"];
      on-click-right = "gnome-system-monitor";
  };
      
  disk = {
      interval = 30;
      #format = "󰋊";
      path = "/";
      #format-alt-click = click;
      format = "{percentage_used}% 󰋊";
      #tooltip = true;
      tooltip-format = "{used} used out of {total} on {path} ({percentage_used}%)";
  };
      
  "hyprland/language" = {
      format = "Lang: {}";
      format-en = "US";
      format-tr = "Korea";
      keyboard-name = "at-translated-set-2-keyboard";
      on-click = "hyprctl switchxkblayout $SET_KB next";
  };
      
  "hyprland/submap" = {
      format = "<span style=\"italic\">  {}</span>"; # Icon: expand-arrows-alt
      tooltip = false;
  };
      
  "hyprland/window" = {
      format = "{}";
      max-length = 40;
      separate-outputs = true;
      offscreen-css  = true;
      offscreen-css-text = "(inactive)";
       rewrite = {
            "(.*) — Mozilla Firefox" = " $1";
            "(.*) - fish" = "> [$1]";
        "(.*) - zsh" = "> [$1]";
        "(.*) - kitty" = "> [$1]";
      };
  };
    
  idle_inhibitor = {
      format = "{icon}";
      format-icons = {
        activated = " ";
        deactivated = " ";
      };
  };
      
  keyboard-state = {
      #numlock = true;
      capslock = true;
      format = {
        numlock = "N {icon}";
      capslock ="󰪛 {icon}";
          };
      format-icons = {
        locked = "";
        unlocked = "";
      };
  };
      
  memory = {
      interval = 10;
      format = "{used:0.1f}G 󰾆";
      format-alt = "{percentage}% 󰾆";
      format-alt-click = "click";
      tooltip = true;
      tooltip-format = "{used:0.1f}GB/{total:0.1f}G";
  };

  mpris = {
      interval = 10;
          format = "{player_icon} ";
          format-paused = "{status_icon} <i>{dynamic}</i>";
          on-click-middle = "playerctl play-pause";
      on-click = "playerctl previous";
      on-click-right = "playerctl next";
      scroll-step = 5.0;
      on-scroll-up = "~/.config/hypr/scripts/volume --inc";
      on-scroll-down = "~/.config/hypr/scripts/volume --dec";
      smooth-scrolling-threshold = 1;
          player-icons = {
          chromium = "";
                  default = "";
          firefox = "";
          kdeconnect = "";
          mopidy = "";
                  mpv = "󰐹";
          spotify = "";
                  vlc = "󰕼";
          };
          status-icons = {
                  paused = "󰐎";
          playing = "";
          stopped = "";
          };
          # ignored-players = [firefox]
          max-length = 30;
  };
        
  network = {
      format = "{ifname}";
      format-wifi = "{icon}";
      format-ethernet = "󰌘";
      format-disconnected = "󰌙";
      tooltip-format = "{ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
      format-linked = "󰈁 {ifname} (No IP)";
      tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
      tooltip-format-ethernet = "{ifname} 󰌘";
      tooltip-format-disconnected = "󰌙 Disconnected";
      max-length = 50;
      format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
  };
    
  "network#speed" = {
      interval = 1;
      format = "{ifname}";
      format-wifi = "{icon}  {bandwidthUpBytes}  {bandwidthDownBytes}";
      format-ethernet = "󰌘   {bandwidthUpBytes}  {bandwidthDownBytes}";
      format-disconnected = "󰌙";
      tooltip-format = "{ipaddr}";
      format-linked = "󰈁 {ifname} (No IP)";
      tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
      tooltip-format-ethernet = "{ifname} 󰌘";
      tooltip-format-disconnected = "󰌙 Disconnected";
      max-length = 50;
      format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
  };
        
  pulseaudio = {
      format = "{icon} {volume}%";
      format-bluetooth = "{icon} 󰂰 {volume}%";
      format-muted = "󰖁";
      format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
      default = ["" "" "󰕾" ""];
      ignored-sinks = ["Easy Effects Sink"];
      };
      scroll-step = 5.0;
      on-click = "~/.config/hypr/scripts/volume --toggle";
      on-click-right = "pavucontrol -t 3";
      on-scroll-up = "~/.config/hypr/scripts/volume --inc";
      on-scroll-down = "~/.config/hypr/scripts/volume --dec";
          tooltip-format = "{icon} {desc} | {volume}%";
      smooth-scrolling-threshold = 1;
  };
        
  "pulseaudio#microphone" = {
      format = "{format_source}";
      format-source = " {volume}%";
      format-source-muted = "";
      on-click = "~/.config/hypr/scripts/volume --toggle-mic";
      on-click-right = "pavucontrol -t 4";
      on-scroll-up = "~/.config/hypr/scripts/volume --mic-inc";
      on-scroll-down = "~/.config/hypr/scripts/volume --mic-dec";
          tooltip-format = "{source_desc} | {source_volume}%";
      scroll-step = 5;
  };
      
  temperature = {
      interval = 10;
      tooltip = true;
      hwmon-path = ["/sys/class/hwmon/hwmon1/temp1_input" "/sys/class/thermal/thermal_zone0/temp"];
      #thermal-zone = 0;
      critical-threshold = 82;
      format-critical = "{temperatureC}°C {icon}";
      format = "{temperatureC}°C {icon}";
      format-icons = ["󰈸"];
  };
        
  tray = {
      icon-size = 15;
      spacing = 8;
  };
        
  wireplumber = {
      format = "{icon} {volume} %";
      format-muted = " Mute";
      on-click = "~/.config/hypr/scripts/volume --toggle";
      on-click-right = "pavucontrol -t 3";
      on-scroll-up = "~/.config/hypr/scripts/volume --inc";
      on-scroll-down = "~/.config/hypr/scripts/volume --dec";
      format-icons = [""  ""  "󰕾"  ""];
  };
        
  "wlr/taskbar" = {
      format = "{icon} {name} ";
      icon-size = 15;
      all-outputs = false;
      tooltip-format = "{title}";
      on-click = "activate";
      on-click-middle = "close";
      ignore-list = [
            "wofi"
            "rofi"
      ];
  };
        
      
  "custom/menu" = {
      format = "  ";
      exec = "echo ; echo 󱓟 app launcher";
      interval  = 86400; # once every day
      tooltip = true;
      on-click = "sh ~/.config/hypr/scripts/menu";
      on-click-right = "sh ~/.config/hypr/scripts/fullmenu";
      # on-click = "nwg-menu -cmd-lock 'hyprlock' -cmd-logout 'hyprctl dispatch exit' -va top -wm 'hyprland'";
  };

  # This is a custom cava visualizer
      
  "custom/playerctl" = {
      format = "<span>{}</span>";
      return-type = "json;";
      max-length = 35;
      exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} ~ {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
      on-click-middle = "playerctl play-pause";
      on-click = "playerctl previous";
      on-click-right = "playerctl next";
      scroll-step = 5.0;
      on-scroll-up = "~/.config/hypr/scripts/volume --inc";
      on-scroll-down = "~/.config/hypr/scripts/volume --dec";
      smooth-scrolling-threshold = 1;
  };


  # Separators
  "custom/separator#dot" = {
      format = "";
      interval = "once";
      tooltip = false;
  };
    
  "custom/separator#dot-line" = {
      format = "";
      interval = "once";
      tooltip = false;
  };
    
  "custom/separator#line" = {
      format = "|";
      interval = "once";
      tooltip = false;
  };
    
  "custom/separator#blank" = {
      # format = ;
      interval = "once";
      tooltip = false;
  };
    
  "custom/separator#blank_2" = {
      format = "  ";
      interval = "once";
      tooltip = false;
  };

  "custom/separator#blank_3" = {
      format = "   ";
      interval = "once";
      tooltip = false;
  };
    
  # Modules below are for vertical layout
    
  "backlight#vertical" = {
      interval = 2;
      align = 0.35;
      rotate = 1;
      format = "{icon}";
      #format-icons = ["󰃞" "󰃟" "󰃠"];
      format-icons = ["" "" "" "" "" "" "" "" "" "" "" "" "" "" ""];
      # on-click = ;
      # on-click-middle = ;
      # on-click-right = ;
      # on-update = ;
      on-scroll-up = "~/.config/hypr/scripts/Brightness.sh --inc";
      on-scroll-down = "~/.config/hypr/scripts/Brightness.sh --dec";
      smooth-scrolling-threshold = 1;
      tooltip-format = "{percent}%";
  };
    
  "clock#vertical" = {
       format = "{:\n%H\n%M\n%S\n\n \n%d\n%m\n%y}";
       interval = 1;
       #format = "{:\n%I\n%M\n%p\n\n \n%d\n%m\n%y}";
       tooltip = true;
       tooltip-format = "{calendar}";
       calendar = {
         mode = "year";
         mode-mon-col = 3;
         format = {
         today = "<span color='#0dbc79'>{}</span>";
         };
       };
  };

  "cpu#vertical" = {
      format = "󰍛\n{usage}%";
      interval = 1;
      on-click-right = "gnome-system-monitor";
  };
    
  "memory#vertical" = {
      interval = 10;
      format = "󰾆\n{percentage}%";
      format-alt = "󰾆\n{used:0.1f}G";
      format-alt-click = "click";
      tooltip = true;
      tooltip-format = "{used:0.1f}GB/{total:0.1f}G";
  };
    
  "pulseaudio#vertical" = {
      format = "{icon}";
      format-bluetooth = "󰂰";
      format-muted = "󰖁";
      format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
      default = [ "" "" "󰕾" "" ];
          tooltip-format = "{icon} {desc} | {volume}%";
      ignored-sinks = ["Easy Effects Sink"];
          };
      scroll-step = 5.0;
      on-click = "~/.config/hypr/scripts/volume --toggle";
      on-click-right = "pavucontrol -t 3";
      on-scroll-up = "~/.config/hypr/scripts/volume --inc";
      on-scroll-down = "~/.config/hypr/scripts/volume --dec";
          tooltip-format = "{icon} {desc} | {volume}%";
      smooth-scrolling-threshold = 1;
  };
    
  "pulseaudio#microphone_vertical" = {
      format = "{format_source}";
      format-source = "󰍬";
      format-source-muted = "󰍭";
      on-click-right = "pavucontrol";
      on-click = "~/.config/hypr/scripts/volume --toggle-mic";
      on-scroll-up = "~/.config/hypr/scripts/volume --mic-inc";
      on-scroll-down = "~/.config/hypr/scripts/volume --mic-dec";
      max-volume = 100;
      tooltip = true;
          tooltip-format = "{source_desc} | {source_volume}%";
  };
    
  "temperature#vertical" = {
      interval = 10;
      tooltip = true;
      hwmon-path = ["/sys/class/hwmon/hwmon1/temp1_input" "/sys/class/thermal/thermal_zone0/temp"];
      #thermal-zone = 0;
      critical-threshold = 80;
      format-critical = "{icon}\n{temperatureC}°C";
      format = " {icon}";
      format-icons = ["󰈸"];
      on-click-right = "kitty --title nvtop sh -c 'nvtop'";
  };
    
  "custom/power_vertical" = {
      format = "⏻";
      exec = "echo ; echo 󰟡 power # blur";
          on-click = "~/.config/hypr/scripts/Wlogout.sh";
      on-click-right = "~/.config/hypr/scripts/ChangeBlur.sh";
      interval  = 86400; # once every day
      tooltip = true;
  };
}];

}
