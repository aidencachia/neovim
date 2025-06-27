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

