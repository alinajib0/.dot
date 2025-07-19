local o = vim.o

o.number = true
o.relativenumber = true
o.mouse = 'a'
o.showmode = false
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
o.breakindent = true
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.signcolumn = 'yes'
o.updatetime = 250
o.timeoutlen = 300
o.splitright = true
o.splitbelow = true
o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.inccommand = 'split'
o.cursorline = true
o.scrolloff = 10
o.confirm = true

o.shell = 'fish'
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.smarttab = true
o.autoindent = true
o.expandtab = true
o.wrap = false
