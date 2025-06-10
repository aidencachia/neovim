require("markview").setup({
  preview = {
    enable      = true,
    filetypes   = { "md", "markdown" },
    splitview_winopts = { split = "right" },
  },
  -- Enable or disable individual renderers:
  markdown = { enable = true },
  latex    = { enable = true },
  html     = { enable = true },
  yaml     = { enable = true },
  typst    = { enable = true },
})

vim.keymap.set("n", "<leader>mv", ":Markview toggle<CR>",      { desc = "Toggle preview" })
vim.keymap.set("n", "<leader>ms", ":Markview splitToggle<CR>", { desc = "Toggle split view" })
vim.keymap.set("n", "<leader>mh", ":Markview hybridToggle<CR>",{ desc = "Toggle hybrid mode" })
