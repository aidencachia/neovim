local builtin = require('telescope.builtin')

function _G.Cword()
  return vim.fn.expand("<cword>")
end

local wk = require("which-key")

wk.add({
  { "<Leader>f", group = "Find", icon = { icon = '󰍉', color = "purple" } },
  {
    mode = 'n',
    { "<Leader>ff", builtin.find_files, desc = "Find Files", icon = { icon = '󰈞', color = "cyan" } },
    { "<Leader>fs", builtin.live_grep, desc = "Find Text in Project (Grep)", icon = { icon = '', color = "green" } },
    { "<Leader>fk", ":Telescope keymaps<CR>", desc = "Find Keyboard Shortcuts", icon = { icon = '', color = "grey" } },
    { "<Leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", desc = "Find Words in Project (Grep W/ Args)", icon = { icon = '', color = "green" } },
    { "<Leader>fr", builtin.oldfiles, desc = "Recent Files", icon = { icon = '󰔟', color = "yellow" } },
    { "<Leader>fm", ":Telescope frecency<CR>", desc = "Frequent Files", icon = { icon = '󱎫', color = "azure" } },
    { "<Leader>fc", ":Telescope themes<CR>", desc = "Find Color Theme", icon = { icon = '', color = "blue" } },
    { "<Leader>fw", group = "Find Current Word", icon = { icon = '󰗧', color = "red" } },
    {
      "<Leader>fww",
      function()
        require('telescope').extensions.live_grep_args.live_grep_args({
          default_text = "[^a-zA-Z]" ..
              Cword() .. "[^a-zA-Z]"
        })
      end,
      desc = "Find Current Word",
      icon = { icon = "󰗧", color = "red" }
    },
    {
      "<Leader>fwd",
      function()
        require('telescope').extensions.live_grep_args.live_grep_args({
          default_text = "\"[^a-zA-Z]" ..
              Cword() .. "[^a-zA-Z]\" --iglob **/main/**"
        })
      end,
      desc = "in Dev",
      icon = { icon = '', color = "blue" }
    },
    {
      "<Leader>fwt",
      function()
        require('telescope').extensions.live_grep_args.live_grep_args({
          default_text = "\"[^a-zA-Z]" ..
              Cword() .. "[^a-zA-Z]\" --iglob **/test/**"
        })
      end,
      desc = "in Tests",
      icon = { icon = '󰙨', color = "green" }
    }
  }
})
