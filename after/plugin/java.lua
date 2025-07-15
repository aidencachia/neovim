local jdtls = require("jdtls.setup")

local function get_maven_modules()
  local jdtls = require("jdtls.setup")
  local root = jdtls.find_root({ "pom.xml", ".git" })
  if not root then return {} end

  -- globpath with `list=true` returns a Lua table (list of filepaths)
  local poms = vim.fn.globpath(root, "**/pom.xml", "", true)

  local mods = {}
  for _, full in ipairs(poms) do
    if full ~= root .. "/pom.xml" then
      -- strip the prefix and suffix to get the module directory
      local rel = full:sub(#root + 2, -(#"/pom.xml" + 1))
      table.insert(mods, rel)
    end
  end

  table.sort(mods)
  return mods
end
-- picker + run
local function pick_and_run()
  local mods = get_maven_modules()
  if vim.tbl_isempty(mods) then
    vim.notify("No modules found in pom.xml tree", vim.log_levels.WARN)
    return
  end
  vim.ui.select(mods, { prompt = "Run module:" }, function(choice)
    if not choice then return end
    vim.cmd("botright split term://mvn -pl " .. choice .. " -am spring-boot:run")
  end)
end

-- picker + debug
local function pick_and_debug()
  local mods = get_maven_modules()
  if vim.tbl_isempty(mods) then
    vim.notify("No modules found in pom.xml tree", vim.log_levels.WARN)
    return
  end
  vim.ui.select(mods, { prompt = "Debug module:" }, function(choice)
    if not choice then return end
    local cmd = table.concat({
      "mvn",
      "-pl", choice,
      "-am",
      "spring-boot:run",
      [[-Dspring-boot.run.jvmArguments="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005"]]
    }, " ")
    vim.cmd("botright split term://" .. cmd)
  end)
end

-- map ’em
vim.keymap.set("n", "<leader>mR", pick_and_run,   { desc = "⊳ Pick & Run Maven Module" })
vim.keymap.set("n", "<leader>mD", pick_and_debug, { desc = "⊳ Pick & Debug Maven Module" })
