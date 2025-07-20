local Path = require('plenary.path')
local session_manager = require('session_manager')
local config = require('session_manager.config')

session_manager.setup({
  sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'),
  session_filename_to_dir = session_filename_to_dir,
  dir_to_session_filename = dir_to_session_filename,
  autoload_mode = config.AutoloadMode.Disabled,
  autosave_last_session = true,
  autosave_ignore_not_normal = true,
  autosave_ignore_dirs = {},
  autosave_ignore_filetypes = {
    'gitcommit',
    'gitrebase',
  },
  autosave_ignore_buftypes = {},
  autosave_only_in_session = false,
  max_path_length = 80,
  load_include_current = false,
})

require('which-key').add({
  { "<leader>S", group = "Session", icon = { icon = '󰦖', color = "purple" } },
  { "<leader>Ss", session_manager.save_current_session, desc = "Save Session", icon = { icon = "󰆓", color = "cyan" } },
  { "<leader>Sl", session_manager.load_current_dir_session, desc = "Load Session", icon = { icon = "󰸧", color = "green" } },
})
