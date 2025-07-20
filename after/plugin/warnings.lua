vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
    -- You can further customize here
  },
  signs = true,
  underline = true,
  update_in_insert = false,
})

vim.fn.sign_define(
  "DiagnosticSignError",
  { text = "", texthl = "DiagnosticSignError", numhl = "" }
)
vim.fn.sign_define(
  "DiagnosticSignWarn",
  { text = "", texthl = "DiagnosticSignWarn", numhl = "" }
)
vim.fn.sign_define(
  "DiagnosticSignInfo",
  { text = "", texthl = "DiagnosticSignInfo", numhl = "" }
)
vim.fn.sign_define(
  "DiagnosticSignHint",
  { text = "", texthl = "DiagnosticSignHint", numhl = "" }
)
