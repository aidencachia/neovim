local Path = require('plenary.path')
local session_manager = require('session_manager')
local config = require('session_manager.config')

session_manager.setup({
  sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
  session_filename_to_dir = session_filename_to_dir,           -- Function that replaces symbols into separators and colons to transform filename into a session directory.
  dir_to_session_filename = dir_to_session_filename,           -- Function that replaces separators and colons into special symbols to transform session directory into a filename. Should use `vim.uv.cwd()` if the passed `dir` is `nil`.
  autoload_mode = config.AutoloadMode.Disabled,
  autosave_last_session = true,                                -- Automatically save last session on exit and on session switch.
  autosave_ignore_not_normal = true,                           -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
  autosave_ignore_dirs = {},                                   -- A list of directories where the session will not be autosaved.
  autosave_ignore_filetypes = {                                -- All buffers of these file types will be closed before the session is saved.
    'gitcommit',
    'gitrebase',
  },
  autosave_ignore_buftypes = {},    -- All buffers of these bufer types will be closed before the session is saved.
  autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
  max_path_length = 80,             -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
  load_include_current = false,     -- The currently loaded session appears in the load_session UI.
})

require('which-key').add({
  { "<leader>S", group = "Session", icon = { icon = '󰦖', color = "purple" } },
  { "<leader>Ss", session_manager.save_current_session, desc = "Save Session", icon = { icon = "󰆓", color = "cyan"}},
  { "<leader>Sl", session_manager.load_current_dir_session, desc = "Load Session", icon = { icon = "󰸧", color = "green"}},
})
