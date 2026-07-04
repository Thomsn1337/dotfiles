vim.pack.add { 'https://github.com/ibhagwan/fzf-lua' }

local fzf = require 'fzf-lua'
fzf.setup()
fzf.register_ui_select()

vim.keymap.set('n', '<leader>sf', fzf.files, { desc = 'Search files' })
vim.keymap.set('n', '<leader>sh', fzf.help_tags, { desc = 'Search help' })
vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = 'Search keymaps' })
vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = 'Search buffers' })
vim.keymap.set('n', '<leader>/', fzf.lgrep_curbuf, { desc = 'Live grep' })

vim.keymap.set('n', '<leader>fn', function()
  fzf.files { cwd = vim.fn.stdpath 'config' }
end, { desc = 'Find files' })
