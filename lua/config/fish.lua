if vim.fn.executable('fish') == 1 then
  vim.opt.shell       = '/usr/bin/fish'
  vim.opt.shellcmdflag= '-c'
  vim.opt.shellquote  = ''
  vim.opt.shellxquote = ''
end
