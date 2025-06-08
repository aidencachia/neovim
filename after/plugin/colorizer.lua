
-- somewhere in your plugin setup (e.g. after installing the plugin)
require("colorizer").setup(
  { "*" },  -- or restrict to { "css", "scss", "html", "javascript" } etc.
  {
    -- keep the basics…
    RGB      = true,    -- #RGB
    RRGGBB   = true,    -- #RRGGBB
    names    = true,    -- “Red”, “blue”, etc.
    -- …but also enable alpha-channel hex and CSS funcs:
    RRGGBBAA = true,    -- #RRGGBBAA and #RGBA hex codes
    rgb_fn   = true,    -- rgb() and rgba() functions
    hsl_fn   = true,    -- hsl() and hsla() functions
    css      = true,    -- shorthand for turning on all of the above
  }
)

-- Enable true color
vim.opt.termguicolors = true

local ccc = require("ccc")
local mapping = ccc.mapping

ccc.setup({
  -- Your preferred settings
  -- Example: enable highlighter
  highlighter = {
    auto_enable = true,
    lsp = true,
  },
})
