return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x",         -- core LSP “preset” (v4)
    dependencies = {
      -- LSP support
      "neovim/nvim-lspconfig",

      -- Mason package manager + lspconfig integration
      {
                "mason-org/mason.nvim",
                lazy = false,
                config = function()
                    require("mason").setup()
                end,
      },
      {
                "mason-org/mason-lspconfig.nvim",
                lazy = false,
                dependencies = { "mason-org/mason.nvim" }
      },
      -- Completion engine + sources
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",

      -- Snippets
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
      },
      "rafamadriz/friendly-snippets",
    },
    -- all actual setup is in after/plugin/lsp.lua
  },
}
