return {
  'ibhagwan/fzf-lua',
  dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
  opts = {},
  config = function()
    local fzf = require 'fzf-lua'

    vim.keymap.set('n', '<leader>ff', fzf.files, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fh', fzf.help_tags, { desc = 'Find help' })
    vim.keymap.set('n', '<leader>fk', fzf.keymaps, { desc = 'Find keymaps' })
    vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = 'Find open buffers' })
    vim.keymap.set('n', '<leader>/', fzf.lgrep_curbuf, { desc = 'Live grep' })

    vim.keymap.set('n', '<leader>fn', function()
      fzf.files { cwd = vim.fn.stdpath 'config' }
    end, { desc = 'Find files' })
  end,
}
