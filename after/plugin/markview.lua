require("markview").setup({
  preview = {
    enable      = true,
    filetypes   = { "md", "markdown" },
    splitview_winopts = { split = "right" },
  },
  experimental = {
    check_rtp = false,
  },
  -- Enable or disable individual renderers:
  markdown = { enable = true },
  latex    = { enable = true },
  html     = { enable = true },
  yaml     = { enable = true },
  typst    = { enable = true },
})

require("which-key").add({
  { "<leader>vm", group = "Markdown", icon = { icon = '', color = "red" } },
  { "<leader>vmv", ":Markview toggle<CR>", desc = "Toggle Markdown Preview" , icon = {icon = '', color = "yellow" } },
  { "<leader>vms", ":Markview splitToggle<CR>", desc = "Toggle Markdown split view", icon = { icon = '', color = "blue" } },
  { "<leader>vmh", ":Markview hybridToggle<CR>", desc = "Toggle Markdown hybrid view", icon = { icon = '', color = "green" } },
})
