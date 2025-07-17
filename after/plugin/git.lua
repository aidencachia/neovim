local neogit = require("neogit")

neogit.setup {
  integrations = {
    diffview = true,      -- enable the 3-way diff popup
  },
}

require("which-key").add({
  { "<leader>g", function () neogit.open({kind="floating"})end, desc = "Open Git Menu"}
})