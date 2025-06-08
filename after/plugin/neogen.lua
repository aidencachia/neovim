require("neogen").setup({
    snippet_engine = "luasnip",    -- or "vsnip", "snippy", etc.
    languages = {
        javascript = {
            template = {
                annotation_convention = "jsdoc",
            },
        },
        typescript = {
            template = {
                annotation_convention = "jsdoc",
            },
        },
    },
})

-- optional mapping: <leader>nf to document the current function 
vim.keymap.set("n", "<leader>nf", ":Neogen<CR>", { desc = "Generate JSDoc" })
