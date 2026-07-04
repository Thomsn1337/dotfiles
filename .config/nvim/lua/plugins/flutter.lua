local plugins = {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-flutter/flutter-tools.nvim',
}

vim.pack.add(plugins)
require('flutter-tools').setup {
  fvm = true,
  settings = {
    showTodos = false,
  },
}
