return  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      local jdtls = require("jdtls")
      local root_dir = require("jdtls.setup").find_root({ "pom.xml", ".git" })
      local workspace_folder = vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

      local config = {
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-jar", vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
          "-configuration", vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_" .. vim.loop.os_uname().sysname:lower(),
          "-data", workspace_folder,
        },
        root_dir = root_dir,
        settings = {
          java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
          },
        },
        init_options = {
          bundles = {},  -- we'll add the debug bundle below
        },
      }

      -- add VSCode Java debug server to bundles
      local java_debug_pkg = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter"
      config.init_options.bundles = vim.tbl_map(function(bundle)
        return java_debug_pkg .. bundle
      end, vim.fn.glob(java_debug_pkg .. "/extension/server/*.jar", true, true))

      jdtls.start_or_attach(config)
    end,
  }
