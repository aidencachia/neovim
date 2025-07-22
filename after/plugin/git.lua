local neogit = require("neogit")

neogit.setup {
  integrations = {
    diffview = true,      -- enable the 3-way diff popup
  },
}


-- This is a new hunk

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

-- 1) Get uncommitted‐change hunk starts from gitsigns
local function get_uncommitted_hunks(bufnr)
  local gs    = require('gitsigns')
  local hks   = gs.get_hunks(bufnr) or {}
  local starts = {}
  for _, h in ipairs(hks) do
    -- pick either added.start or changed.start
    local s = (h.added and h.added.start)
           or (h.changed and h.changed.start)
    if s then table.insert(starts, s) end
  end
  return starts
end

-- 2) Get committed‐MR hunk starts via `git diff <base> -U0`
local function get_mr_hunks(bufnr)
  local fn    = vim.fn
  local file  = fn.expand('%:p')
  if fn.filereadable(file) == 0 then
    return {}
  end
  local base  = 'origin/main'  -- ← adjust to your MR’s target branch
  local cmd   = 'git diff '..base..' -U0 -- '..fn.shellescape(file)
  local diff  = fn.systemlist(cmd)
  local starts = {}
  for _, ln in ipairs(diff) do
    -- parse: @@ -A,B +C,D @@
    local cstart, ccnt = ln:match('@@ %-%d+,?%d* %+(%d+),?(%d*) @@')
    if cstart then
      cstart = tonumber(cstart)
      ccnt   = tonumber(ccnt) or 1
      -- only push the first line of this hunk
      table.insert(starts, cstart)
    end
  end
  return starts
end

-- 3) Combine, sort, dedupe, and that’s your hunk boundaries
local function get_hunk_boundaries()
  local bufnr = vim.api.nvim_get_current_buf()
  local all   = {}

  -- collect both kinds
  for _, s in ipairs(get_uncommitted_hunks(bufnr)) do
    table.insert(all, s)
  end
  for _, s in ipairs(get_mr_hunks(bufnr)) do
    table.insert(all, s)
  end

  if vim.tbl_isempty(all) then
    return {}
  end

  table.sort(all)
  -- dedupe
  local uniq = { all[1] }
  for i = 2, #all do
    if all[i] ~= all[i-1] then
      table.insert(uniq, all[i])
    end
  end

  return uniq
end

-- 4) jump function
local function jump_hunk(prev)
  local bnds = get_hunk_boundaries()
  if #bnds == 0 then
    vim.notify("No diff‐hunks in this buffer", vim.log.levels.INFO)
    return
  end

  local cur = vim.api.nvim_win_get_cursor(0)[1]
  if prev then
    for i = #bnds, 1, -1 do
      if bnds[i] < cur then
        return vim.api.nvim_win_set_cursor(0, { bnds[i], 0 })
      end
    end
    -- wrap
    vim.api.nvim_win_set_cursor(0, { bnds[#bnds], 0 })
  else
    for _, ln in ipairs(bnds) do
      if ln > cur then
        return vim.api.nvim_win_set_cursor(0, { ln, 0 })
      end
    end
    -- wrap
    vim.api.nvim_win_set_cursor(0, { bnds[1], 0 })
  end
end

-- 5) Expose your keymaps
vim.keymap.set('n', ']h', function() jump_hunk(false) end,
  { desc = 'Next diff hunk (uncommitted or MR)' })
vim.keymap.set('n', '[h', function() jump_hunk(true) end,
  { desc = 'Prev diff hunk (uncommitted or MR)' })

-- return nothing; just gets loaded