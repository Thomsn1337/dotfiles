local plugins = {
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/NMAC427/guess-indent.nvim',
}

vim.pack.add(plugins)

require('todo-comments').setup { signs = false }
require('nvim-autopairs').setup()
require('ibl').setup()
require('guess-indent').setup {}
