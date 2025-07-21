local hooks = require "ibl.hooks"

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "IblNormal", { fg = "#444444" })
  vim.api.nvim_set_hl(0, "IblScope", { fg = "#00ffff" })
end)

require("ibl").setup {
  indent = {
    char = '▏',
    highlight = "IblNormal"
  },
  scope = {
    enabled = true,
    char = '▎',
    highlight = "IblScope"
  }
}