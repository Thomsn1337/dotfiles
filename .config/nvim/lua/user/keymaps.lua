local key = vim.keymap.set

key({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
key('i', 'jk', '<ESC>')

-- Remap for dealing with word wrap
key('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
key('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Telescope keymaps
key('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = 'Find recently opened files' })
key('n', '<leader><space>', require('telescope.builtin').buffers, { desc = 'List open buffers' })
key('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find, { desc = 'Fuzzy find in current buffer' })
key('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search git files' })
key('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Search files' })
key('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Search help' })
key('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Search by grep' })
key('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = 'Search diagnostics' })

-- Diagnostic keymaps
key('n', 'dk', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
key('n', 'dj', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
key('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
