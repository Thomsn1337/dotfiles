-- Ensure that Lazy package manager is installed
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require('lazy').setup({

    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- GUI to install LSP servers
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
        },
    },

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
    },

    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim', opts = {} },

    -- Adds git related signs to the gutter, as well as utilities for managing changes
    { 'lewis6991/gitsigns.nvim' },

    -- Catppuccin theme, the best
    { "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    },

    { 'nvim-tree/nvim-web-devicons' },

    -- Vim motion practice
    { "ThePrimeagen/vim-be-good" },

    -- Set lualine as statusline
    { 'nvim-lualine/lualine.nvim' },

    {
        -- Indentation guides
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
    },

    { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    -- Fuzzy Finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
    },

    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },

}, {})
