return {
  "SidOfc/mkdx",    -- or any bibtex plugin
  ft = { "bib", "tex" },
  config = function()
    -- e.g. Telescope integration:
    vim.api.nvim_set_keymap("n", "<leader>cb",
      "<cmd>Telescope bibtex.bibtex{}<CR>",
      { noremap = true, silent = true })
  end,
}
