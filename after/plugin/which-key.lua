vim.g.mapleader = " "

-- Function to compile & run current file
local function compile_and_run()
  -- if there’s a project-local run.sh, just use that
  local project_script = vim.fn.getcwd() .. "/run.sh"
  if vim.fn.filereadable(project_script) == 1 then
    -- pass the current file as an argument
    local script = vim.fn.shellescape(project_script)
    vim.cmd("botright split | resize 15 | terminal bash " .. script)
    return
  end

  local file      = vim.fn.expand("%")
  local fname     = vim.fn.expand("%:r")
  local ft        = vim.bo.filetype
  local templates = {
    c      = "gcc %s -o %s && ./%s",
    cpp    = "g++ %s -std=c++17 -O2 -o %s && ./%s",
    python = "python3 %s",
    java   = "javac %s && java %s",
    go     = "go run %s",
    rust   = "rustc %s && ./%s",
    sh     = "bash %s",
  }
  local tpl       = templates[ft]
  if not tpl then
    vim.notify("No run command for filetype: " .. ft, vim.log.levels.WARN)
    return
  end
  local cmd = string.format(tpl, file, fname, fname)
  vim.cmd("split | terminal " .. cmd)
end

-- Map <F5> to compile_and_run()
require("which-key").add({
  { "<C-h>", '<Cmd>wincmd h<Cr>', mode = "n", desc = "Move to Left Panel" },
  { "<C-l>", '<Cmd>wincmd l<Cr>', mode = "n", desc = "Move to Right Panel" },
  { "<C-j>", '<Cmd>wincmd j<Cr>', mode = "n", desc = "Move to Bottom Panel" },
  { "<C-k>", '<Cmd>wincmd k<Cr>', mode = "n", desc = "Move to Top Panel" },
  { "<Leader>s", group = "Create Split", icon = { icon = '', color = "yellow" } },
  { "<Leader>sh", '<Cmd>vsplit<Cr>', mode = "n", desc = "Vertical Split", proxy = "<leader>sl", icon = { icon = '', color = "green" } },
  { "<Leader>sj", '<Cmd>split<Cr>', mode = "n", desc = "Horizontal Split", proxy = "<leader>sk", icon = { icon = '', color = "orange" } },
  { "<F5>", compile_and_run, mode = "n", desc = "Compile and Run current file" },
  { "<leader>v", group = "View", icon = { icon = '󰈈', color = "green" } },
  { '<leader>u', vim.cmd.UndotreeToggle, mode = 'n', desc = "Toggle Undo Tree", icon = { icon = '', color = 'red' } },
})