{ lib, ... }:

{
  services.mako = {
    enable = true;
    anchor = "top-right";
    actions = true;
    
    borderRadius = 4;
    borderSize = 2;
    height = 100;
    width = 300;
    margin = "10";
    padding = "15"; 
    maxIconSize = 48;

    backgroundColor = lib.mkForce "#1E1E2E";
    textColor = lib.mkForce "#D9E0EE";
    borderColor = lib.mkForce "#313244";
    progressColor = lib.mkForce "over #89B4FA";
    
    icons = true;
    maxVisible = 5;
    sort = "-time";
    defaultTimeout = 4000;
    ignoreTimeout = true;
    layer = "overlay";
    markup = true;
    extraConfig = lib.mkForce ''
      max-history=100
      
      on-button-left=dismiss
      on-button-middle=none
      on-button-right=dismiss-all
      on-touch=dismiss

      [urgency=low]
      background-color=#1e1e2eFF
      border-color=#313244
      default-timeout=2000

      [urgency=normal]
      border-color=#313244
      default-timeout=3000
      
      [urgency=high]
      background-color=#1e1e2eFF
      border-color=#f38ba8
      text-color=#f38ba8
      default-timeout=0

      [category=mpd]
      background-color=#1e1e2eFF
      border-color=#f9e2af
      default-timeout=2000
      group-by=category
    '';
  };
}
