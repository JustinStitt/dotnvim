local dap = require("dap")

-- Configuration for C and C++ using CodeLLDB
dap.configurations.cpp = {
  {
    name = "Launch file (CodeLLDB)",
    type = "codelldb", -- MUST match the adapter name registered in dap.adapters
    request = "launch",
    program = function()
      -- Ask for the executable to debug when starting
      return vim.fn.input(
        "Path to executable: ",
        vim.fn.getcwd() .. "/",
        "file"
      )
    end,
    cwd = "${workspaceFolder}", -- Run the program in the project root
    stopOnEntry = false, -- Stop at main() automatically?
    args = {}, -- Pass arguments to the executable: e.g., args = {"arg1", "arg2"}
    -- Optional: Add setup commands for LLDB if needed
    -- initCommands = ["command script import /path/to/lldb/commands"],
    preRunCommands = { "settings set target.process.follow-fork-mode child" },
  },
}

-- Use the same config for C by default
dap.configurations.c = dap.configurations.cpp
