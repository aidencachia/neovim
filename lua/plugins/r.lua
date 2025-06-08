return {
    {
        "jalvesaq/Nvim-R",
        ft = { "r", "rmd" },
        config = function()
            -- tell Nvim-R to use your existing R REPL (e.g. in tmux)
            vim.g.R_assign = 0                -- use <- or = for assignment
            vim.g.R_console = "tmux"
            vim.g.R_tmux_split = "horizontal" -- or "vertical"
            -- keymapping: <LocalLeader><Enter> to send current line or selection
            vim.g.R_no_map_keys = 1           -- disable default maps if you want your own
        end
    },
    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown", "rmd" },
        build = "cd app && npm install",
        config = function()
            vim.g.mkdp_auto_start = 1
            vim.g.mkdp_open_to_the_world = 0
            vim.g.mkdp_browser = "firefox"

            vim.api.nvim_set_keymap("n", "<leader>rk", ":!Rscript -e \"rmarkdown::render('%')\"<CR>",
                { noremap = true, silent = true })
        end
    }
}
