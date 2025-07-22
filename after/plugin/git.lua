local neogit = require("neogit")

neogit.setup {
  integrations = {
    diffview = true,      -- enable the 3-way diff popup
  },
}

require("which-key").add({
  { "<C-g>", function () neogit.open({kind="floating"})end, desc = "Open Git Menu"}
})

-- 1) define a pink “▏” sign for MR-changes
vim.cmd('highlight GitLabMRSign guifg=#ff79c6 guibg=NONE')
vim.fn.sign_define('GitLabMRSign', {
  text   = '▏',         -- thin vertical bar
  texthl = 'GitLabMRSign',
})

-- 2) function to clear & re-place our MR signs
local function update_mr_scroll()
  local fn    = vim.fn
  local buf   = vim.api.nvim_get_current_buf()
  local file  = fn.expand('%:p')
  if fn.filereadable(file) == 0 then return end

  -- unplace anything we did last time
  fn.sign_unplace('GitLabMRScroll', { buffer = buf })

  -- run a zero-context diff vs your MR’s base
  local base = 'origin/main'  -- ← change this if your MR target is different
  local cmd  = 'git diff ' .. base .. ' -U0 -- ' .. fn.shellescape(file)
  local diff = fn.systemlist(cmd)

  -- parse each hunk header and place a sign on *every* added/changed line
  for _, line in ipairs(diff) do
    local start, cnt = line:match('@@ %-%d+,?%d* %+(%d+),?(%d*) @@')
    if start then
      start = tonumber(start)
      cnt   = tonumber(cnt) or 1
      for l = start, start + cnt - 1 do
        fn.sign_place(0,            -- auto-id
                      'GitLabMRScroll',  -- our group
                      'GitLabMRSign',    -- sign defined above
                      buf,
                      { lnum = l })
      end
    end
  end
end

-- 3) autocmds to keep it up-to-date
vim.api.nvim_create_autocmd(
  { 'BufEnter', 'BufWritePost', 'TextChanged', 'TextChangedI' },
  { callback = update_mr_scroll }
)
