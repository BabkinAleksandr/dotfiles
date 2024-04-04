-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

local nvim_tree = require('nvim-tree')

nvim_tree.setup({
    sort_by = 'case_sensitive',
    view = {
        width = 35,
        side = 'right'
    },
    renderer = {
        indent_markers = {
            enable = true
        },
        group_empty = true,
        icons = {
            show = {
                folder = false,
            }
        }
    },
    filters = {
        dotfiles = false
    },
    git = {
        ignore = false
    }
})
