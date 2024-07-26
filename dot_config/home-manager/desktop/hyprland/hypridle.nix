# this is the idle configuration file
{
services.hypridle.enable = true;
services.hypridle.settings = {
  general = {
    lock_cmd = "notify-send \"lock!\"; pidof hyprlock || hyprlock";         # avoid starting multiple hyprlock instances.
    unlock_cmd = "notify-send \"unlock!\"";                                 # same as above, but unlock
    before_sleep_cmd = "notify-send \"Zzz\"; pidof hyprlock || hyprlock";   # lock before suspend.
    after_sleep_cmd = "hyprctl dispatch dpms on; notify-send \"Awake!\"";   # to avoid having to press a key twice to turn on the display.
  };

  listener = [
    # DECREASE BACKLIGHT
    {
      timeout = 150;    # 2.5min.
      on-timeout = "brightnessctl -s set 1";    # set monitor backlight to minimum, avoid 0 on OLED monitor.
      on-resume = "brightnessctl -r";           # monitor backlight restore.
    }
    # LOCK SCREEN
    {
      timeout = 300;    # 5min
      on-timeout = "if [[ ! $(pactl list | grep State | grep RUNNING) ]]; then hyprlock; fi";  # lock screen
    }
    # TURN OFF SCREEN
    {
      timeout = 330;    # 5.5min
      on-timeout = "if [[ ! $(pactl list | grep State | grep RUNNING) ]]; then hyprctl dispatch dpms off; fi";  # turn off screen
    }
    # GO INTO SUSPEND MODE
    {
      timeout = 3600;   # 60min
      on-timeout = "systemctl suspend"; # suspend pc
    }
  ];
};

}
