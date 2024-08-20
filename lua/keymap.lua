vim.g.mapleader = " "

-- Window Traversial
vim.keymap.set("n", "<C-h>",'<Cmd>wincmd h<Cr>')
vim.keymap.set("n", "<C-l>",'<Cmd>wincmd l<Cr>')
vim.keymap.set("n", "<C-j>",'<Cmd>wincmd j<Cr>')
vim.keymap.set("n", "<C-k>",'<Cmd>wincmd k<Cr>')

-- Window Creation
vim.keymap.set("n", "<C-S-h>",'<Cmd>vsplit<Cr>')
vim.keymap.set("n", "<C-S-l>",'<Cmd>vsplit<Cr>')
vim.keymap.set("n", "<C-S-J>",'<Cmd>split<Cr>')
vim.keymap.set("n", "<C-S-k>",'<Cmd>split<Cr>')

-- LSP Commands

vim.keymap.set("n", "<Leader>lr", function() vim.lsp.buf.references() end, opts)
vim.keymap.set("n", "<Leader>la", function() vim.lsp.buf.code_action() end, opts)
