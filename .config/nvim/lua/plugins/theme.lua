local plugins = {
  'https://github.com/folke/tokyonight.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
}

vim.pack.add(plugins)

require('tokyonight').setup()
vim.cmd.colorscheme 'tokyonight-night'

require('lualine').setup {}
