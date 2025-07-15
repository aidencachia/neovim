-- KNAP functions
-- F5 processes the document once and refreshes the view
vim.api.nvim_set_keymap('i', '<F5>', '<C-o>:lua require("knap").process_once()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<F5>', '<C-c>:lua require("knap").process_once()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F5>', ':lua require("knap").process_once()<CR>', { noremap = true, silent = true })

-- F6 closes the viewer application and allows settings to be reset
vim.api.nvim_set_keymap('i', '<F6>', '<C-o>:lua require("knap").close_viewer()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<F6>', '<C-c>:lua require("knap").close_viewer()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F6>', ':lua require("knap").close_viewer()<CR>', { noremap = true, silent = true })

-- F7 toggles the auto-processing on and off
vim.api.nvim_set_keymap('i', '<F7>', '<C-o>:lua require("knap").toggle_autopreviewing()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<F7>', '<C-c>:lua require("knap").toggle_autopreviewing()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F7>', ':lua require("knap").toggle_autopreviewing()<CR>', { noremap = true, silent = true })

-- F8 invokes a SyncTeX forward search, or similar, where appropriate
vim.api.nvim_set_keymap('i', '<F8>', '<C-o>:lua require("knap").forward_jump()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<F8>', '<C-c>:lua require("knap").forward_jump()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F8>', ':lua require("knap").forward_jump()<CR>', { noremap = true, silent = true })

