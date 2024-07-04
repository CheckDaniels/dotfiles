require "nvchad.mappings"

local map = vim.keymap.set

map("n","<leader>qq", "<cmd> lua os.exit() <CR>", { desc = "QUICK EXIT"})
map("n","<leader>wq", "<cmd> wq <CR>", { desc = "WRITE & QUIT"})
map("n","<leader>ww", "<cmd> w <CR>", { desc = "WRITE"})
map({"i","n","v"},"<A-e>",
  function()
    local mymodule = require("nvchad.modules")
    mymodule.tmux_split_with_ranger()
  end,
  { desc = "Open new ranger session in current path"}
)
map({"i","n","v"},"<A-CR>",
  function()
    local mymodule = require("nvchad.modules")
    mymodule.tmux_split_with_zsh()
  end,
  { desc = "Open new zshell session in current path"}
)

--| Tmux Navigation |--
map("n","<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "window left" })
map("n","<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "window right" })
map("n","<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "window down" })
map("n","<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "window up" })

--| quick trash-delete |--
map("n","<C-A-d>",
  function()
    local mymodule = require("nvchad.modules")
    mymodule.quick_deletion()
  end,
  { desc = "quick delete" }
)


--| run script with compiler/interpreter |--
map("n",'<leader>rr',
  -- function to run the script based on the file type
  function ()
    local mymodule = require("nvchad.modules")
    mymodule.run_script()
  end,
  { desc = "Run current script" }
)


--| UndoTreeToggle |--
map("n","<leader>u", "<cmd> UndotreeToggle<CR>", { desc = "Toggle UndoTree" })

--| TagbarToggle |--
map("n","<leader>tb", "<cmd> TagbarToggle<CR>", { desc = "Toggle Tagbar" })


--| create python venv folder |--
map("n",'<leader>pyv',
  function()
    local mymodule = require("nvchad.modules")
    mymodule.create_venv()
  end,
  { desc = "Create Python venv" }
)

--| create CMakeList.txt |--
map("n","<leader>mcl",
  function()
    local mymodule = require("nvchad.modules")
    mymodule.create_CMakelist()
  end,
  { desc = "create CMakeList" }
)
--| add to CMakeList.txt |--
map("n","<leader>mca",
  function()
    local mymodule = require("nvchad.modules")
    mymodule.add_to_CMakelist()
  end,
  { desc = "add to CMakeList" }
)

--| build : cmake/make |--
map("n","<leader>mcb",
  -- builds the make file with cmake and the executable with make
  function()
    local mymodule = require("nvchad.modules")
    mymodule.cmake_build()
  end,
  { desc = "build Makefile/Executable" }
)
--| run release |--
map("n","<leader>mcr",
  -- create the executable with make and run it
  function ()
    local mymodule = require("nvchad.modules")
    mymodule.cmake_run()
  end,
  { desc = "make Executable and Run" }
)
--| run debug |--
map("n","<leader>mcd",
  -- create the executable with make and debug it
  function ()
    local mymodule = require("nvchad.modules")
    mymodule.cmake_debug()
  end,
  { desc = "build Executable and Debug" }
)
