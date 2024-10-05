{ inputs, ... }:

{
programs.nixvim = {
  keymaps = [

    # GENERAL 

    { # Save & Quit
      action = "<cmd> wq <CR>";
      key = "<Leader>wq";
      mode = "n";
    } {
      action = "<cmd> lua os.exit() <CR>";
      key = "<Leader>qq";
      mode = "n";
    } {
      action = "<cmd> w <CR>";
      key = "<Leader>ww";
      mode = "n";
    } { # toggle relative numbers
      action = "<cmd> set relativenumber! <CR>";
      key = "<Leader>rn";
      mode = "n";
    } { # toggle comment
      action = "gcc";
      key = "<Leader>/";
      mode = "n";
      options.remap = true;
    } {
      action = "gc";
      key = "<Leader>/";
      mode = "v";
      options.remap = true;
    # } { # rename variables -> needs to go to lspconfig
    #   action = "<cmd> lua require(\"renamer\").rename() <CR>";
    #   key = "<Leader>a";
    #   mode = [ "n" "v" ];
    } { # improved navigation in insert mode
      action = "<Up>";
      key = "<C-k>";
      mode = "i";
    } {
      action = "<Down>";
      key = "<C-j>";
      mode = "i";
    } {
      action = "<Left>";
      key = "<C-h>";
      mode = "i";
    } {
      action = "<Right>";
      key = "<C-l>";
      mode = "i";
    }

    # PLUGINS
    
    {   # NvimTree
      action = "<cmd>NvimTreeToggle<CR>";
      key = "<C-n>";
      options.silent = true;
    } { # UndoTree
      action = "<cmd>UndotreeToggle<CR>";
      key = "<Leader>u";
      mode = "n";
    } { # ToggleTerm
      action = "<cmd>ToggleTerm<CR>";
      key = "<C-t>";
      mode = [ "n" "t" ];
    } { # Rnvimr
      action = "<cmd> RnvimrToggle <CR>";
      key = "<Leader>rr";
      mode = "n";
    } { # TreeSitterContext
      action = "<cmd> TSContextToggle <CR>";
      key = "<Leader>ct";
      mode = "n";
    } {
      action = "<C-\\><C-n>";
      key = "<C-x>";
      mode = "t";
    } { # Tagbar
      action = "<cmd> TagbarToggle <CR>";
      key = "<Leader>tb";
      mode = "n";
    }
    # Telescope
    {
      action = "<cmd> Telescope help_tags <CR>";
      key = "<Leader>fh";
      mode = "n";
    } {
      action = "<cmd> Telescope current_buffer_fuzzy_find <CR>";
      key = "<Leader>fz";
      mode = "n";
    } {
      action = "<cmd> Telescope marks <CR>";
      key = "<Leader>fm";
      mode = "n";
    }
    # WhichKey
    {
      action = "<cmd> WhichKey <CR>";
      key = "<Leader>wk";
      mode = "n";
    }
    # TmuxNavigator
    {
      action = "<cmd> TmuxNavigateLeft <CR>";
      key = "<C-h>";
      mode = "n";
    } {
      action = "<cmd> TmuxNavigateRight <CR>";
      key = "<C-l>";
      mode = "n";
    } {
      action = "<cmd> TmuxNavigateDown <CR>";
      key = "<C-j>";
      mode = "n";
    } {
      action = "<cmd> TmuxNavigateUp<CR>";
      key = "<C-k>";
      mode = "n";
    }
    # Bufferline
    {
      action = "<cmd> BufferLineCycleNext <CR>";
      key = "<C-PageDown>";
      mode = [ "n" "i" "v" ];
    } {
      action = "<cmd> BufferLineCyclePrev <CR>";
      key = "<C-PageUp>";
      mode = [ "n" "i" "v" ];
    } {
      action = "<cmd> BufferLineMoveNext <CR>";
      key = "<C-S-PageDown>";
      mode = [ "n" "i" "v" ];
    } {
      action = "<cmd> BufferLineMovePrev <CR>";
      key = "<C-S-PageUp>";
      mode = [ "n" "i" "v" ];
    } { # close buffer
      action = "<cmd> bd <CR><cmd> bn <CR>";
      key = "<Leader>x";
      mode = "n";
    } { # close buffer
      action = "<cmd> bd <CR><cmd> bn <CR>";
      key = "<C-w>";
      mode = "n";
    } { # ZenMode enable
      action = "<cmd> ZenMode <CR>";
      key = "<Leader>zm";
      mode = "n";
    }

    # IMPROVEMENTS/HACKS TO NEOVIM
    { # move text down in visual mode
      action = ":m '>+1<CR>gv=gv";
      key = "J";
      mode = "v";
    } { # move text up ''
      action = ":m '<-2<CR>gv=gv";
      key = "K";
      mode = "v";
    } { # keep cursor while deleting newlines characters
      action = "mzJ`z";
      key = "J";
      mode = "n";
    } { # improved half page up
      action = "<C-u>zz";
      key = "<C-u>";
      mode = "n";
    } { # improved half page down
      action = "<C-D>zz";
      key = "<C-d>";
      mode = "n";
    } { # improved yanking
      action = "\"_dP";
      key = "p";
      mode = "x";
    } { # improved deleting
      action = "\"_d";
      key = "<Del>";
      mode = "v";
    } { # Disable Q
      action = "<nop>";
      key = "Q";
      mode = "n";
    } { # CTRL+C = Esc
      action = "<Esc>";
      key = "<C-c>";
      mode = "i";
    } { # remaped x back to cut: issue -> leap.nvim
      action = "d";
      key = "x";
      mode = "v";
    }

    # QUICKFIXES
    { # move to next quickfix
      action = "<cmd>cnext<CR>zz";
      key = "<C-k>";
      mode = "n";
    } { # move to prev quickfix
      action = "<cmd>cprev<CR>zz";
      key = "<C-j>";
      mode = "n";
    } { # move to next list
      action = "<cmd>lprev<CR>zz";
      key = "<Leader>k";
      mode = "n";
    } { # move to prev list
      action = "<cmd>lprev<CR>zz";
      key = "<Leader>j";
      mode = "n";
    }

    # TMUX PANE SPLIT
    {
      key = "<A-e>";
      mode = [ "i" "n" "v" ];
      action = ''<cmd> lua vim.fn.system("tmux split-window -c " .. vim.fn.getcwd() .. " '~/.config/ranger/ranger_cd.sh'") <CR>'';
      options = {
        desc = "Open new ranger session in current path";
        noremap = true;
        silent = true;
      };
    }
    
    {
      key = "<A-CR>";
      mode = [ "i" "n" "v" ];
      action = ''<cmd> lua vim.fn.system("tmux split-window -c " .. vim.fn.getcwd()) <CR>
      '';
    options = {
        desc = "Open new zshell session in current path";
        noremap = true;
        silent = true;
      };
    }

  ];
};
}
