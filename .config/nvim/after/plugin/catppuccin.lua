require("catppuccin").setup({
    flavour = "macchiato",
    transparent_background = true,
    term_colors = true,
    integrations = {
        fidget = true,
        indent_blankline = {
            enabled = true,
            scope_color = "blue"
        },
        mason = true
    }
})

vim.cmd.colorscheme "catppuccin"
