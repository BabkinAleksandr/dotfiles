return {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    enabled = false,
    config = function()
        vim.opt.list = true
        vim.opt.listchars:append("space:·")

        local ibl = require("ibl")
        ibl.setup({
            scope = {
                enabled = false,
            },
            indent = { char = "┊" },
        })
    end,
}
