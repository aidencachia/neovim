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
vim.g.vimtex_quickfix_mode   = 0
-- enable indenting
vim.g.vimtex_indent_enabled  = 1

-- Keybindings (you can tweak these):
vim.api.nvim_set_keymap("n", "<leader>ll", "<cmd>VimtexCompile<CR>",     { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>le", "<cmd>VimtexErrors<CR>",      { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ls", "<cmd>VimtexCompileStatus<CR>",{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lF', '<Plug>(vimtex-forward-search)', { silent = true })
vim.keymap.set('n', '<leader>lv', function()
  -- open the PDF (or relaunch it)
  vim.cmd('VimtexView')        -- runs :VimtexView
  -- then jump to the current cursor position
  vim.fn['vimtex#view#forward_search']()
end, { silent = true })

-- always enable conceal for nice math rendering
vim.o.conceallevel = 2
vim.o.concealcursor = "nc"

-- folding with Treesitter
vim.o.foldmethod = "expr"
vim.o.foldexpr   = "nvim_treesitter#foldexpr()"

-- useful key
vim.api.nvim_set_keymap("n", "<leader>zc", "za", { noremap = true })
