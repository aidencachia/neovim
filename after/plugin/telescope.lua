local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
function _G.Cword()
    return vim.fn.expand("<cword>")
end

vim.keymap.set("n", "<Leader>fww",  function () require('telescope').extensions.live_grep_args.live_grep_args({ default_text = "[^a-zA-Z]"..Cword().."[^a-zA-Z]"}) end)
vim.keymap.set("n", "<Leader>fwd",  function () require('telescope').extensions.live_grep_args.live_grep_args({ default_text = "\"[^a-zA-Z]"..Cword().."[^a-zA-Z]\" --iglob **/main/**"}) end)
vim.keymap.set("n", "<Leader>fwt",  function () require('telescope').extensions.live_grep_args.live_grep_args({ default_text = "\"[^a-zA-Z]"..Cword().."[^a-zA-Z]\" --iglob **/test/**"}) end)

