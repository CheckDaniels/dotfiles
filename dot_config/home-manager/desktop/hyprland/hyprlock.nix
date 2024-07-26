# This is the lockscreen configuration file
{
programs.hyprlock.enable = true;

# HYPRLOCK SETTINGS
programs.hyprlock.settings = {
  # source = "~/.cache/wal/colors-hyprland.conf";

  # BACKGROUND
  background = {
    # monitor =
    path = "~/.config/hypr/wallpapers/ign_rick_3840x2160.png";
    blur_passes = 0;
    contrast = 0.8916;
    brightness = 0.7172;
    vibrancy = 0.1696;
    vibrancy_darkness = 0.0;
  };

  # GENERAL
  general = {
    no_fade_in = false;
    grace = 0;
    disable_loading_bar = true;
  };

  # INPUT FIELD
  input-field = {
    # monitor =
    size = "250, 60";
    outline_thickness = 1;
    dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
    dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
    dots_center = true;
    outer_color = "rgba(0, 0, 0, 0)";
    inner_color = "rgba(0, 0, 0, 0.5)";
    font_color = "rgb(200, 200, 200)";
    fade_on_empty = false;
    font_family = "JetBrains Mono Nerd Font Mono";
    placeholder_text = "<i><span foreground=\"##cdd6f4\">Input Password...</span></i>";
    hide_input = false;
    rounding = 5;
    position = "0, -120";
    halign = "center";
    valign = "center";
  };


  label = [
    # TIME
    {
      # monitor =
      text = "cmd[update:1000] echo \"$(date +\"%-H:%M\")\"";
      color = "$foreground";
      # color = "rgba(255, 255, 255, 0.6)";
      font_size = 120;
      font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
      position = "0, -300";
      halign = "center";
      valign = "top";
    }
    # USER
    {
      # monitor =
      text = "Hi there, $USER";
      color = "$foreground";
      #color = "rgba(255, 255, 255, 0.6)";
      font_size = 25;
      font_family = "JetBrains Mono Nerd Font Mono";
      position = "0, -40";
      halign = "center";
      valign = "center";
    }
  ];

  # # CURRENT SONG
  # label = {
  #     monitor =
  #     text = cmd[update:1000] echo "$(~/Documents/Scripts/whatsong.sh)" 
  #     color = $foreground
  #     #color = rgba(255, 255, 255, 0.6)
  #     font_size = 18
  #     font_family = JetBrainsMono, Font Awesome 6 Free Solid
  #     position = 0, -50
  #     halign = center
  #     valign = bottom
  # };
};
}
