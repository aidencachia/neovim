local dap = require('dap')
local dapui = require('dapui')
require('nvim-dap-virtual-text').setup()

-- Configure DAP adapter for CodeLLDB (recommended) or fallback to lldb-vscode
dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- Adjust 'codelldb' command to its installed path if necessary
    command = "codelldb",
    args = { "--port", "${port}" },
  }
}

-- DAP configurations for C/C++ and Rust
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'codelldb', -- matches the adapter above
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- dap-ui setup
dapui.setup()
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

-- Keybindings for debugging
local wk = require("which-key")
wk.add({
  { '<leader>d', group = "Debugger", icon = { icon = '', color = "red" } },
  {
    mode = 'n',
    { '<leader>db', dap.toggle_breakpoint, desc = "Toggle Breakpoint", icon = { icon = '', color = "red" } },
    { '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Condition: ')) end, desc = "Set Conditional Breakpoint", icon = { icon = '', color = "red" } },
    { '<leader>dl', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, desc = "Set Log Point", icon = { icon = '', color = "red" } },
    { '<leader>dr', dap.repl.open, desc = "Open REPL", icon = { icon = '', color = "red" } },
    { '<leader>dt', dap.terminate, desc = "Terminate", icon = { icon = '', color = "red" } },
    { '<leader>du', dapui.toggle, desc = "Toggle UI", icon = { icon = '󰈈', color = "red" } },
  }
})

wk.add({
  { '<F6>', dap.continue, desc = 'Debug: Continue/Start', icon = { icon = '', color = "red" } },
  { '<F10>', dap.step_over, desc = 'Debug: Step Over', icon = { icon = '󰆷', color = "red" } },
  { '<F11>', dap.step_into, desc = 'Debug: Step Into', icon = { icon = '󰆹', color = "red" } },
  { '<F12>', dap.step_out, desc = 'Debug: Step Out', icon = { icon = '󰆸', color = "red" } },
})
