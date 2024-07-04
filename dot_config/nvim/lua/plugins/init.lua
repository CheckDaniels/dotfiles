return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- Plugin Manager
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
        "codelldb",
        "debugpy",
        "black",
        "mypy",
        "ruff",
        "typescript-language-server",
        "json-lsp",
        "pyright",
      }
    }
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  ---------
  -- LSP --
  ---------

  -- null(none)-ls, lsp-toolings for neovim
  -- {
  --   "nvimtools/none-ls.nvim",
  --   ft = {"python"},
  --   opts = function()
  --     return require "custom.configs.null-ls"
  --   end,
  -- },
  -- Language Server protocol, used between a tool and a language. In this case: Treesitter c - clangd
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  ---------------
  -- scrollbar --
  ---------------
  {
    "dstein64/nvim-scrollview",
    lazy = false,
  },

  -----------
  -- marks --
  -----------
  {
    "chentoast/marks.nvim",
    config = function()
      require("marks").setup({
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = { ".", "<", ">", "^" },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions. 
        -- higher values will have better performance but may cause visual lag, 
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- disables mark tracking for specific buftypes. default {}
        excluded_buftypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = "⚑",
          virt_text = "hello world",
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = false,
        },
        mappings = {}
      })
    end,
  },

  ------------
  -- tagbar --
  ------------
  {
    "preservim/tagbar",
    cmd = 'TagbarToggle',
  },
  --------------
  -- UndoTree --
  --------------

  {
    "mbbill/undotree",
    cmd = 'UndotreeToggle',
  },

  ------------
  -- py_lsp --
  ------------

  -- {
  --   'HallerPatrick/py_lsp.nvim',
  --   config = function()
  --     require('py_lsp').setup({
  --     -- This is optional, but allows to create virtual envs from nvim
  --     host_python = "/bin/python3.12",
  --     default_venv_name = ".venv", -- For local venv
  --     })
  --   end,
  -- },


  --------------
  -- Debugger --
  --------------

  -- debugger protocol, enables the ability to debugg code. In this case the debugger is "codelldb"
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    config = function(_,opts)
      local map = vim.keymap.set
      --| nvim-dap |--
      map("n","<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line"})
      map("n","<leader>dcr", "<cmd> DapContinue <CR>", { desc = "Start or continue the debugger"})
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = {"python"},
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      local map = vim.keymap.set
      --| dap-python |--
      map("n","<leader>dpr",
        function()
          require('dap-python').test_method()
        end,
        { desc = "Run Python file" }
      )
    end,
  },

  -- linker for mason and dap
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {}
    },
  },

  {
    "nvim-neotest/nvim-nio",
  },
  -- user interface for debugger
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {"mfussenegger/nvim-dap","nvim-neotest/nvim-nio"},
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
}
