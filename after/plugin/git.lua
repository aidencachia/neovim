local neogit = require("neogit")

neogit.setup {
  integrations = {
    diffview = true,      -- enable the 3-way diff popup
  },
}

require("which-key").add({
  { "<C-g>", function () neogit.open({kind="floating"})end, desc = "Open Git Menu"}
})

-- 1) define a pink “full block” sign for MR-changes
vim.cmd('highlight GitLabMRSign guifg=#ff79c6 guibg=NONE')
vim.fn.sign_define('GitLabMRSign', {
  text   = '│',            -- full-block is much thicker than ▏
  texthl = 'GitLabMRSign',
})

local function update_mr_scroll()
  local fn   = vim.fn
  local buf  = vim.api.nvim_get_current_buf()
  local file = fn.expand('%:p')
  if fn.filereadable(file) == 0 then return end

  -- remove old MR signs
  fn.sign_unplace('GitLabMRScroll', { buffer = buf })

  -- diff vs your MR base (change 'origin/main' if needed)
  local cmd  = 'git diff origin/main -U0 -- ' .. fn.shellescape(file)
  local diff = fn.systemlist(cmd)

  for _, line in ipairs(diff) do
    local start, cnt = line:match('@@ %-%d+,?%d* %+(%d+),?(%d*) @@')
    if start then
      start = tonumber(start)
      cnt   = tonumber(cnt) or 1
      for l = start, start + cnt - 1 do
        fn.sign_place(0,                    -- auto-id
                      'GitLabMRScroll',     -- our group
                      'GitLabMRSign',       -- the sign defined above
                      buf,
                      { lnum = l, priority = 4 })
      end
    end
  end
end

-- 3) refresh on edits / writes / buffer switches
vim.api.nvim_create_autocmd(
  { 'BufEnter', 'BufWritePost', 'TextChanged', 'TextChangedI' },
  { callback = update_mr_scroll }
)