local M = {}


---------------
-- Shortcuts --
---------------


M.quick_deletion = function()
  local lib = require('nvim-tree.lib')
  local node = lib.get_node_at_cursor()
  local function on_exit()
    vim.cmd("NvimTreeRefresh")
    print("trash: '" .. node.absolute_path .. "'")
  end

  if node then
    vim.fn.jobstart('gio trash "' .. node.absolute_path .. '"', {
      detach = false,
      on_exit = on_exit,
    })
  end
end

-- executes the current script
M.run_script = function ()
  local current_bufnr = vim.fn.bufnr('%')
  local filetype = vim.api.nvim_buf_get_option(current_bufnr,"filetype")
  local current_file = vim.fn.expand('%:t')
  local current_file_no_extension = vim.fn.expand('%:t:r')
  local command = ''

  if filetype == 'c' then
    command = string.format("clang --debug %s -o bin/%s", current_file, current_file_no_extension)
  elseif filetype == 'cpp' then
    command = string.format("clang++ --debug %s -o bin/%s", current_file, current_file_no_extension)
  elseif filetype == 'python' then
    command = string.format(". venv/bin/activate && python '%s'", current_file)
  else
    print("Unsupported file type for this command")
    return
  end
  require("nvchad.term").runner {
    pos = "sp",
    cmd = command,
    id = "ekk",
    clear_cmd = false
  }
end


------------
-- Python --
------------

M.create_venv = function()
  require("nvchad.term").runner {
    pos = "sp",
    cmd = "python3.12 -m venv venv",
    id = "ekk",
    clear_cmd = false
  }
end



--------------------
-- CMakeLists.txt --
--------------------


-- Function to create a CMakeLists.txt file
M.create_CMakelist = function()
  -- gets the current cmakeVersion
  local cmakeVersion = function()
    local file = io.popen("cmake --version 2>&1")
    local output = file:read('*a')
    file:close()

    local version = string.match(output, "cmake version ([0-9]+%.[0-9]+%.[0-9]+)")

    return version or "Not Found"
  end
  local folder_name = string.gsub(vim.fn.expand("%:p:h:t")," ", "_")
  local current_folder = vim.fn.expand("%:p:h")
  local files = vim.fn.glob(current_folder .. "/*.{c,h}",0,1)

  -- creates the content of CMakeLists.txt
  local add_exec_cmd =
    "cmake_minimum_required(VERSION ".. cmakeVersion() ..")\n"..
    "project(".. folder_name .. " C)\n"..
    "\n"..
    "# Set the compilers to Clang\n"..
    "# set(CMAKE_C_COMPILER \"clang\")\n"..
    "# set(CMAKE_CXX_COMPILER \"clang++\")\n"..
    "\n"..
    "# if no cmake_build_type is defined the default build_type is release\n"..
    "if(NOT CMAKE_BUILD_TYPE)\n"..
    "   set(CMAKE_BUILD_TYPE Release)\n"..
    "endif()\n"..
    "\n"..
    "# Set the flags for the build_type"..
    "set(CMAKE_C_FLAGS_DEBUG \"${CMAKE_C_FLAGS_DEBUG} -Wall -Wextra -Wpedantic -g -O0\")\n"..
    "set(CMAKE_C_FLAGS_RELEASE \"${CMAKE_C_FLAGS_RELEASE} -O3\")\n"..
    "set(CMAKE_C_STANDARD 23)\n"..
    "\n"..
    "# Set the output directory for executables\n"..
    "set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/../bin)\n"..
    "include_directories(.)\n"..
    "\n"..
    "add_executable(".. folder_name

  for _, file in ipairs(files) do
      local file_name = vim.fn.fnamemodify(file, ":t")
      add_exec_cmd = add_exec_cmd .. "\n               " .. file_name
    end
    add_exec_cmd = add_exec_cmd .. ")"

    local CMakeLists = io.open("CMakeLists.txt", "w")
    CMakeLists:write(add_exec_cmd)
    CMakeLists:close()
end

-- function to add current file to the CMakeLists.txt
M.add_to_CMakelist = function()
  local filename = vim.fn.fnamemodify(vim.fn.expand('%'), ':t')
  print(filename)

  -- deletes the last bracket ')'
  local CMakeLists = io.open("CMakeLists.txt", "r")
  -- copies the content, before: ')'
  local content = CMakeLists:read("*a")
  CMakeLists:close()

  -- opens CMakeLists again in write mode
  CMakeLists = io.open("CMakeLists.txt", "w")
  local length = #content --gets the length
  -- adds the content back
  CMakeLists:write(content:sub(1, length-1))


  if "c" == filename:sub(-1) or "h" == filename:sub(-1) then
    CMakeLists:write("\n               " .. filename)
  end
  -- adds the ')' back to the end
  CMakeLists:write(")")
  CMakeLists:close()
end




-------------------------
-- CMake build and run --
-------------------------

local function get_projectname()
  -- Construct the grep command to extract the project name
  local grep_output = io.popen("grep -oP 'project\\(\\s*\\K\\w+' CMakeLists.txt", 'r')
  -- reads the terminal output
  local projectname = grep_output:read('*a')
  -- Close the popen process
  grep_output:close()
  -- returns the projectname
  return projectname
end

M.cmake_build = function()
  -- cmakeCommand for building the build folders, one for debugging the other one for release tests.
  local release_cmakeCommand = " cmake -DCMAKE_BUILD_TYPE=Release -S . -B build-release"
  local debug_cmakeCommand = "cmake -DCMAKE_BUILD_TYPE=Debug -S . -B build-debug"
  -- makeCommand for creating the Executable
  local r_makeCommand = "make -C build-release"
  local d_makeCommand = "make -C build-debug"

  require("nvchad.term").runner {
    pos = "sp",
    -- sends cmake-command to terminal and then the makeCommand if it succeeds
    cmd = "("..release_cmakeCommand.." && "..r_makeCommand..") & ("..debug_cmakeCommand.." && "..d_makeCommand..")",
    id = "ekk",
    clear_cmd = false
  }

  end


M.cmake_run = function()
  -- makeCommand for creating the Executable
  local r_makeCommand = "make -C build-release"
  -- exeCommand for running the Executable inside the bin
  local exeCommand = "bin/"..get_projectname()

  require("nvchad.term").runner {
    pos = "sp",
    -- sends makeCommand to the terminal and then the exeCommand if it succeeds
    cmd = r_makeCommand.." & ".. exeCommand,
    id = "ekk",
    clear_cmd = false
  }
end

M.cmake_debug = function()
  -- makeCommand for creating the Executable
  local d_makeCommand = "make -C build-debug"
  -- exeCommand for running the Executable inside the bin
  local exeCommand = "bin/"..get_projectname()

  require("nvchad.term").runner {
    pos = "sp",
    -- sends makeCommand to the terminal and then the exeCommand if it succeeds
    cmd = d_makeCommand.." & ".. exeCommand,
    id = "ekk",
    clear_cmd = false
  }
end

-- Function to get the current session path and open a new tmux pane with zshell in that path
M.tmux_split_with_zsh= function()
  -- Check if a session is active
  if session_path == '' then
    print("No session is currently active.")
  else
    -- Get the directory of the current neovim-session
    local session_dir = vim.fn.getcwd()

    -- Construct the tmux command to open a new pane with the session directory
    local tmux_command = "tmux split-window -t tmux:0 -c " .. session_dir

    -- Execute the tmux command
    vim.fn.system(tmux_command)
  end
end

-- Function to get the current session path and open a new tmux pane with ranger in that path
M.tmux_split_with_ranger= function()
  -- Check if a session is active
  if session_path == '' then
    print("No session is currently active.")
  else
    -- Get the directory of the current neovim-session
    local session_dir = vim.fn.getcwd()

    -- Construct the tmux command to open a new pane with the session directory
    local tmux_command = "tmux split-window -t tmux:0 -c " .. session_dir .. " 'export EDITOR=nvim VISUAL=nvim;. ranger;zsh'"

    -- Execute the tmux command
    vim.fn.system(tmux_command)
  end
end

return M
