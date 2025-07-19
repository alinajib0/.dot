local map = vim.keymap.set

map('n', 'x', '"_x')
map('n', '<Leader>p', '"0p')
map('n', '<Leader>P', '"0P')
map('v', '<Leader>p', '"0p')
map('n', '<Leader>c', '"_c')
map('n', '<Leader>C', '"_C')
map('v', '<Leader>c', '"_c')
map('v', '<Leader>C', '"_C')
map('n', '<Leader>d', '"_d')
map('n', '<Leader>D', '"_D')
map('v', '<Leader>d', '"_d')
map('v', '<Leader>D', '"_D')

map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('t', '<leader><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', '<A-h>', ':vertical resize -2<CR>', { noremap = true, silent = true })
map('n', '<A-j>', ':resize +2<CR>', { noremap = true, silent = true })
map('n', '<A-k>', ':resize -2<CR>', { noremap = true, silent = true })
map('n', '<A-l>', ':vertical resize +2<CR>', { noremap = true, silent = true })

map('n', '+', '<C-a>')
map('n', '-', '<C-x>')

map('n', '<C-a>', 'gg<S-v>G')

map('n', 'te', ':tabedit')

map('n', 'sh', ':split<Return>')
map('n', 'ss', ':vsplit<Return>')

map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

map('n', 'J', 'mzJ`z')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', '=ap', "ma=ap'a")
map('n', '<leader>zig', '<cmd>LspRestart<cr>')

map('i', '<C-c>', '<Esc>')
map('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- Horizontal terminal (default)
vim.keymap.set('n', '<C-\\>', '<cmd>ToggleTerm direction=horizontal<CR>', { desc = 'Toggle horizontal term' })

-- Vertical terminal
vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm size=80 direction=vertical<CR>', { desc = 'Toggle vertical term' })

-- Floating terminal
vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm direction=float<CR>', { desc = 'Toggle floating term' })

-- Tabing terminal
vim.keymap.set('n', '<leader>tg', '<cmd>ToggleTerm direction=tab<CR>', { desc = 'Toggle floating term' })

-- autocommand
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
