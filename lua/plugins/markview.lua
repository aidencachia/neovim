return {
  "OXY2DEV/markview.nvim",
  lazy = false,                -- must load before nvim-treesitter
  config = function()
    require("markview").setup({
      preview = {
        enable      = true,
        filetypes   = { "md", "markdown", "rmd", "quarto" },
        splitview_winopts = { split = "right" },
      },
      -- add any other custom options here
    })
  end,
}
