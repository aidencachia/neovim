local harpoon = require("harpoon")
harpoon:setup({})

require("which-key").add({
  { "<leader>b", group = "Bookmarks", icon = { icon = '', color = 'purple'}},
  { "<leader>ba", function() harpoon:list():add() end, mode = "n", desc = "Add to Bookmarks", icon = { icon = '󰃅', color = "green" } },
  { "<leader>bd", function() harpoon:list():remove() end, mode = "n", desc = "Remove from Bookmarks", icon = { icon = '󰧌', color = "red" } },
  { "<leader>bl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, mode = "n", desc = "Bookmark list", icon = { icon = '󱥬', color = "cyan" } },
  { "<leader>b1", function() harpoon:list():select(1) end, mode = "n", desc = "Go to First Bookmark"},
  { "<C-1>", function() harpoon:list():select(1) end, mode = "n", desc = "Go to First Bookmark"},
  { "<leader>b2", function() harpoon:list():select(2) end, mode = "n", desc = "Go to Second Bookmark"},
  { "<C-2>", function() harpoon:list():select(2) end, mode = "n", desc = "Go to Second Bookmark" },
  { "<leader>b3", function() harpoon:list():select(3) end, mode = "n", desc = "Go to Third Bookmark"},
  { "<C-3>", function() harpoon:list():select(3) end, mode = "n", desc = "Go to Third Bookmark" },
  { "<leader>b4", function() harpoon:list():select(4) end, mode = "n", desc = "Go to Forth Bookmark"},
  { "<C-4>", function() harpoon:list():select(4) end, mode = "n", desc = "Go to Forth Bookmark" },
  { "<leader>bj", function() harpoon:list():prev() end, mode = "n", desc = "Go to previous Bookmark" },
  { "<leader>bk", function() harpoon:list():next() end, mode = "n", desc = "Go to next Bookmark" }
})
