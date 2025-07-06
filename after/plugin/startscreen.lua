local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  [[░       ░░░░      ░░░   ░░░  ░░  ░░░░  ░░  ░░░░  ░░  ░░░░  ░░        ░░  ░░░░  ░]],
  [[▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒▒    ▒▒  ▒▒  ▒▒▒  ▒▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒▒▒▒▒  ▒▒▒▒▒   ▒▒   ▒]],
  [[▓  ▓▓▓▓  ▓▓  ▓▓▓▓  ▓▓  ▓  ▓  ▓▓     ▓▓▓▓▓  ▓▓▓▓  ▓▓▓  ▓▓  ▓▓▓▓▓▓  ▓▓▓▓▓        ▓]],
  [[█  ████  ██        ██  ██    ██  ███  ███  ████  ████    ███████  █████  █  █  █]],
  [[█       ███  ████  ██  ███   ██  ████  ███      ██████  █████        ██  ████  █]],
}

local telescope = require('telescope.builtin')
local harpoon = require("harpoon")
local session_manager = require('session_manager')

dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "󰈞  Find file", telescope.find_files),
  dashboard.button("r", "󰔟  Recently opened files", telescope.oldfiles),
  dashboard.button("m", "  Frecency", ":Telescope frecency<CR>"),
  dashboard.button("w", "󰈬  Find word", telescope.live_grep),
  dashboard.button("b", "  Bookmarks", ":lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<CR>"),
  dashboard.button("s", "  Restore Session", ":lua require('session_manager').load_current_dir_session()<CR>"),
  dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
}

alpha.setup(
  dashboard.opts
)
