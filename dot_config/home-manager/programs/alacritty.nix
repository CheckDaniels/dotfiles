# Alacritty configuration-file
{ config, pkgs, ...}:

{
  programs.alacritty.enable = true;
  programs.alacritty.settings = {

    # fixing colors
    env.TERM = "xterm-256color";

    # resizing with fixed increments
    window.resize_increments = true;

  };
}
