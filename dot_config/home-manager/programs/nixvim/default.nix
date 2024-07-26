# Nixvim configuration-file
{ inputs, pkgs, config, ... }:

{ 
imports = [ 
  inputs.nixvim.homeManagerModules.nixvim
  ./lualine.nix 
  ./mappings.nix
];
home.shellAliases.v = "nvim";

# NixVim
programs.nixvim = {

  enable = true;
  defaultEditor = true;
  
  viAlias = true;
  vimAlias = true;
  luaLoader.enable = true;
  
  colorschemes.nord.enable = true;

  clipboard.providers.wl-copy.enable = true;

  autoCmd = [
    {
      command = "normal zR";
      event = [
        "BufWinEnter"
        "BufReadPost"
        "FileReadPost"
      ];
      pattern = "*";
    }
    {
      command = "TSContextDisable";
      event = "VimEnter";
      pattern = "*";
    }
  ];

  opts = {
    number = true;
    relativenumber = false;

    shiftwidth = 2;
    cursorline = true;
    undofile = true;
    scrolloff = 8;
    fillchars = "eob: ";
    clipboard="unnamedplus";
  };
  extraConfigVim = ''
    set whichwrap+=h,l
    set fillchars+=vert:┃
    highlight WinSeparator guifg=#${config.colorScheme.palette.base02}
  '';

  globals = {
    mapleader = " ";
  };

  plugins = {
    auto-save.enable = true;
    # autoclose.enable = true; # for autclosing brackets, quotes, etc.
    better-escape.enable = true;
    bufferline.enable = true;
    # cmp-buffer.enable = true;
    # cmp-cmdline.enable = true;
    # cmp_luasnip.enable = true;
    # cmp-path.enable = true;
    comment.enable = true; 
    dap.enable = true; # need to take a look at it
    direnv.enable = true; # need to take a look at it
    # some git-utilities
    friendly-snippets.enable = true; # snippets collection
    harpoon.enable = true; # need to take a look at it
    hmts.enable = true; # enable syntax highlighting for text in nix
    illuminate.enable = true;
    leap.enable = true; 
    lsp.enable = true; # need to take a look at it
    lualine.enable = true;
    luasnip.enable = true; # need to take a look at it
    marks.enable = true; 
    nix.enable = true;
    nvim-tree.enable = true;
    # obsidian.enable = true;
    persistence.enable = true; # session management
    # refactoring.enable = true; # from the primeagen
    # sleuth.enable = true; # in case there are issues with the shiftwidth
    spider.enable = true; # faster w,e,b movement (for words)
    startify.enable = true; # information when opening neovim
    surround.enable = true; # add [] "" '' ... to text section
    tagbar.enable = true; # see functions, classes, etc.
    telescope.enable = true;
    tmux-navigator.enable = true;
    treesitter.enable = true;
    treesitter-context.enable = true; # keep the context
    treesitter-textobjects.enable = true; # for advanced editing (TSPlaygroundToggle) and auto-inteding
    # treesitter-refactor.enable = true; # refactoring
    trouble.enable = true; # tool for viewing issues and warnings 
    ts-autotag.enable = true; # converts <div> to <div></div>
    toggleterm.enable = true;
    twilight.enable = true; # focus on the current code only (zen-mode)
    undotree.enable = true;
    vim-css-color.enable = true;
    # wakatime.enable = true; # tracking programming activity
    which-key.enable = true;
    zen-mode.enable = true;
  };

  plugins.lsp = {
    servers = {

      # javascript / typescript
      tsserver.enable = true;

      # lua
      lua-ls.enable = true;

    };
  };

  plugins.nvim-tree = {
    hijackCursor = true;
    syncRootWithCwd = true;
    extraOptions = {
      renderer = {
        root_folder_label = false;
        highlight_git = true;
        highlight_opened_files = "none";
	
        indent_markers = {
          enable = true;
        };
      };
      view = {
	signcolumn = "no";
      };
    };
  };

  plugins.cmp = {
    enable = true; # automatic code completion
    autoEnableSources = true;
    settings.sources = [
      { name = "buffer"; }
      { name = "cmdline"; }
      { name = "luasnip"; }
      { name = "nvim-lsp"; }
      { name = "path"; }
    ];
    settings.mapping = {
      "<C-Space>" = "cmp.mapping.complete()";
      "<C-d>" = "cmp.mapping.scroll_docs(-4)";
      "<C-e>" = "cmp.mapping.close()";
      "<C-f>" = "cmp.mapping.scroll_docs(4)";
      "<CR>" = "cmp.mapping.confirm({ select = true })";
      "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
      "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
    };
    settings.snippet = {
      expand = "function(args) require('luasnip').lsp_expand(args.body) end";
    }; 
  };

  # plugins.autoclose.options = {
  #   autoIndent = false;
  # };

  extraPlugins = with pkgs.vimPlugins; [
    nvim-lspconfig
    {
      plugin = nvim-lspconfig;
      config = ''
	lua require("lspconfig").lua_ls.setup{}
      '';
    }
    rnvimr
  ];
};

}
