local lsp_zero = require('lsp-zero')
local telescope = require('telescope.builtin')

local function lsp_attach(_, bufnr) -- runs on LspAttach :contentReference[oaicite:8]{index=8}
    local opts = { buffer = bufnr }

    require("which-key").add({
        {
            mode = 'n',
            { "<leader>c", group = "Code", icon = { icon = '', color = "green" } },
            { "<leader>ch", vim.lsp.buf.hover, desc = "Code Info", icon = { icon = '', color = "cyan" } },
            { "<leader>cd", vim.lsp.buf.definition, desc = "Definition" },
            { "<leader>cD", vim.lsp.buf.declaration, desc = "Decleration" },
            { "<leader>ci", vim.lsp.buf.implementation, desc = "Implementation" },
            { "<leader>co", vim.lsp.buf.type_definition, desc = "Type Definition" },
            { "<leader>cr", telescope.lsp_references, desc = "References" },
            { "<leader>cs", vim.lsp.buf.signature_help, desc = "Signature Help" },
            { "<F2>", vim.lsp.buf.rename, desc = "Rename" },
            { "<F3>", function() vim.lsp.buf.format({ async = true }) end, desc = "Reformat" },
            { "<F4>", vim.lsp.buf.code_action, desc = "Code Action" }
        }
    }, opts)
end
-- 1) Extend lspconfig defaults (capabilities, attach, UI) ------------------------
lsp_zero.extend_lspconfig({
    sign_text    = true,                                         -- show signs and reserve gutter space :contentReference[oaicite:5]{index=5}
    float_border = 'rounded',                                    -- nicer borders on hovers & signature help :contentReference[oaicite:6]{index=6}
    capabilities = require('cmp_nvim_lsp').default_capabilities(), -- enable cmp capabilities :contentReference[oaicite:7]{index=7}
    lsp_attach   = lsp_attach
})

require("mason").setup()

require('mason-lspconfig').setup({
    ensure_installed = { "cssls", "jsonls", "ltex", 'texlab', 'pyright', 'ts_ls', 'bashls', 'lua_ls' }, -- adjust servers as needed :contentReference[oaicite:10]{index=10}
    automatic_installation = true,
    handlers = {
        function(server_name)                     -- default handler
            require('lspconfig')[server_name].setup({}) -- picks up extend_lspconfig defaults :contentReference[oaicite:11]{index=11}
        end,
    },
})

-- 3) nvim-cmp + LuaSnip --------------------------------------------------------
local cmp = require('cmp')

cmp.setup({
    sources = {
        { name = 'nvim_lsp' }, -- LSP completions :contentReference[oaicite:12]{index=12}
        { name = 'luasnip' }, -- snippet completions }, snippet = { expand = function(args)                               -- expand via LuaSnip :contentReference[oaicite:13]{index=13} require('luasnip').lsp_expand(args.body)
    },

    mapping = cmp.mapping.preset.insert({ -- use native-like keybindings :contentReference[oaicite:14]{index=14}
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = 'insert' }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'insert' }),
        ['<C-p>'] = cmp.mapping(function()
            if cmp.visible() then cmp.select_prev_item() else cmp.complete() end
        end),
        ['<C-n>'] = cmp.mapping(function()
            if cmp.visible() then cmp.select_next_item() else cmp.complete() end
        end),
        ['<C-e>'] = cmp.mapping.abort(),
    }),

    completion = {
        completeopt = 'menu,menuone,noinsert', -- avoid unwanted auto-insert :contentReference[oaicite:15]{index=15}
    },
})

-- 4) (Optional) Load VSCode-style snippets for LuaSnip --------------------------
require('luasnip.loaders.from_vscode').lazy_load()

local lspconfig = require("lspconfig")

lspconfig.texlab.setup({
    on_attach = function(client, _)
        -- optionally disable semantic tokens (vimtex handles syntax)
        client.server_capabilities.semanticTokensProvider = nil
    end,
    settings = {
        texlab = {
            build = {
                executable = "latexmk",
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                onSave = true,
            },
            forwardSearch = {
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
            },
        },
    },
})

lspconfig.ltex.setup({
    filetypes = { "tex", "bib", "markdown", "text", "gitcommit" },
    settings = {
        ltex = {
            -- pick your default language
            language = "en-UK",
            -- enable extra, “picky” rules
            additionalRules = { enablePickyRules = true },
            -- add any custom words you want to whitelist
            dictionary = {
                ["en-UK"] = { "Neovim", "LTEX", "Zathura" }
            },
        },
    },
    on_attach = lsp_attach, -- reuse your existing on_attach with keymaps
})

lspconfig.cssls.setup({
    on_attach    = lsp_attach, -- your existing on_attach
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    settings     = {
        css = {
            experimental = {
                customData = { vim.fn.expand("~/.config/nvim/etc/custom-formating-rules/waybar.css-data.json") },
            },
        },
        scss = {
            experimental = {
                customData = { vim.fn.expand("~/.config/nvim/etc/custom-formating-rules/waybar.css-data.json") },
            },
        },
        less = {
            experimental = {
                customData = { vim.fn.expand("~/.config/nvim/etc/custom-formating-rules/waybar.css-data.json") },
            },
        },
    },
})

lspconfig.clangd.setup({
    cmd = { "clangd", "--compile‐commands‐dir=${workspaceFolder}/build" },
})


local mason_root               = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local launcher_jar             = vim.fn.glob(mason_root .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_dir               = mason_root .. "/config_linux"
local workspace                = vim.fn.getcwd() -- or wherever you want your workspace data
local java_debug_pkg           = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter"
local bundles                  = vim.fn.glob(java_debug_pkg .. "/extension/server/*.jar", true, true)
local util                     = require("lspconfig.util")
local root_dir                 = util.root_pattern("pom.xml", "build.gradle", ".git")(vim.fn.getcwd())

local config                   = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-jar", launcher_jar,
        "-configuration", config_dir,
        "-data", workspace,
    },
    root_dir = root_dir,
    settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
        },
    },
    init_options = {
        bundles = bundles, -- we'll add the debug bundle below
    },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = lsp_attach,
}

-- folder name of the current working directory
local folder_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

-- only inject the formatter for certain folders
local needs_eclipse_fmt = vim.tbl_contains(
  { "bmc-api" }, -- whitelist
  folder_name
)

if needs_eclipse_fmt then
  config.settings = config.settings or {}
  config.settings.java = config.settings.java or {}
  config.settings.java.format = {
    settings = {
      url = "file://" .. vim.fn.expand("~/BMC-Formatting-Eclipse.xml")
    },
  }
end

-- add VSCode Java debug server to bundles
lspconfig.init_options.bundles = vim.tbl_map(function(bundle)
    return java_debug_pkg .. bundle
end, vim.fn.glob(java_debug_pkg .. "/extension/server/*.jar", true, true))

require("jdtls").start_or_attach(config)