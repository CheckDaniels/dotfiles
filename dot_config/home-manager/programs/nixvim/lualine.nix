{ inputs, ... }:

{
programs.nixvim = {

  plugins.lualine = {
    componentSeparators = { left = " "; right = " "; };
    sectionSeparators = { left = ""; right = ""; };
    sections = {
      lualine_a = [ { name = "mode"; separator.left = ""; padding = { right = 1; left = 1; }; } ];
      lualine_b = [ "filename" "branch" ];
      lualine_c = [ "%=" ];  # add your center compoentnts here in place of this comment
      lualine_x = [];
      lualine_y = [ "progress" ];
      lualine_z = [ { name = "location"; separator.right = ""; padding = { right = 1; left = 1; }; } ];
    };
    inactiveSections = {
      lualine_a = [];
      lualine_b = [];
      lualine_c = [];
      lualine_x = [];
      lualine_y = [];
      lualine_z = [];
    };
  };
};
}

