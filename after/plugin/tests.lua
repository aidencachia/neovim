local neotest = require("neotest")

neotest.setup({
    adapters = {
        require("neotest-java")({
            command     = { "mvn", "test", "-q" },
            results_dir = "target/surefire-reports",
            -- config here
        }),
    },
})
require("which-key").add({
    { "<leader>tt", neotest.run.run,                                      desc = "Run nearest test" },
    { "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end,   desc = "Test whole file" },
    { "<leader>td", function() neotest.run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
    { "<leader>ts", neotest.run.stop,                                     desc = "Stop Test" },
    { "<leader>ta", neotest.run.attach,                                   desc = "Attach test" }
})
