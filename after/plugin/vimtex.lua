-- use latexmk as your compiler
vim.g.vimtex_compiler_method = "latexmk"

if vim.fn.has("macunix") == 1 then
  vim.g.vimtex_view_method = "skim"
elseif vim.fn.has("win32") == 1 then
  vim.g.vimtex_view_method = "sumatrapdf"
else
  vim.g.vimtex_view_method = "zathura"
end

-- don't open quickfix automatically
vim.g.vimtex_quickfix_mode  = 0
-- enable indenting
vim.g.vimtex_indent_enabled = 1

-- Keybindings (you can tweak these):
require("which-key").add({
  { "<leader>l", group = "Latex", icon = { icon = '󰊄', color = "grey" } },
  { "<leader>ll", "<cmd>VimtexCompile<CR>", mode = "n", desc = "Compile Document" },
  { "<leader>le", "<cmd>VimtexErrors<CR>", mode = "n", desc = "Get Document Errors" },
  { "<leader>ls", "<cmd>VimtexCompileStatus<CR>", mode = "n", desc = "Check Compilation Status" },
  { "<leader>lv", "<cmd>VimtexView<CR>:", mode = "n", desc = "View Latex Document" },
  { "<leader>lb", "<cmd>Telescope bibtex.bibtex{}<CR>", mode = "n", desc = "View Citations" }
}, { silent = true })

-- always enable conceal for nice math rendering
vim.o.conceallevel  = 2
vim.o.concealcursor = "nc"

-- folding with Treesitter
vim.o.foldmethod    = "expr"
vim.o.foldexpr      = "nvim_treesitter#foldexpr()"
