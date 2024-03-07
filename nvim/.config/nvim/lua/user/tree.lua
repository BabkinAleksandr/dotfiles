-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

local nvim_tree = require("nvim-tree")

nvim_tree.setup({
    sort_by = "case_sensitive",
    view = {
        width = 30
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true
    },
})
