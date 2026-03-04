return {
  {
    'nvim-mini/mini.icons',
    config = function()
      require('mini.icons').mock_nvim_web_devicons()
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {},
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {}, -- this is equalent to setup({}) function
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'storm',
    },
    config = function()
      vim.cmd.colorscheme 'tokyonight'
    end,
  },
}
