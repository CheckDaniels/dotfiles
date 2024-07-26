{ pkgs, ... }:

{
  # Stylix : for theming everything
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  stylix.cursor = {
    package = pkgs.nordic;
    name = "Nordic-cursors";
    size = 16;
  };
  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override { fonts = ["JetBrainsMono"]; };
      name = "JetBrainsMono Nerd Font";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
    sizes.terminal = 12;
    sizes.applications = 10;
    sizes.desktop = 12;
    sizes.popups = 12;
  };
  stylix.image = ./wallpapers/ign_dudeOnBuilding3.png;
  stylix.targets.chromium.enable = false;
}
