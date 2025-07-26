-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'sitiom/nvim-numbertoggle',
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  -- {
  --   'mluders/comfy-line-numbers.nvim',
  --   config = function()
  --     require('comfy-line-numbers').setup {
  --       up_key = 'k',
  --       down_key = 'j',
  --       hidden_file_types = { 'undotree' },
  --       hidden_buffer_types = { 'terminal' },
  --     }
  --   end,
  -- },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      size = 20,
      open_mapping = false, -- Disable default mapping (we'll set our own)
      direction = 'horizontal', -- Default direction (can be overridden)
      float_opts = {
        border = 'curved',
        width = 120,
        height = 30,
      },
    },
  },
  {
    {
      'mistweaverco/kulala.nvim',
      keys = {
        { '<leader>ns', desc = 'Send request' },
        { '<leader>na', desc = 'Send all requests' },
        { '<leader>nb', desc = 'Open scratchpad' },
      },
      ft = { 'http', 'rest' },
      opts = {
        global_keymaps = false,
        global_keymaps_prefix = '<leader>R',
        kulala_keymaps_prefix = '',
      },
    },
  },
}
