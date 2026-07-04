vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

local conform = require 'conform'
conform.setup {
  notify_on_error = false,
  format_on_save = {
    lsp_format = 'fallback',
    timeout_ms = 500,
  },
  default_format_opts = {
    lsp_format = 'fallback',
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  conform.format { async = true }
end, { desc = '[F]ormat buffer' })
