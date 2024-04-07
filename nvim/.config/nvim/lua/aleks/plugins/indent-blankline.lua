return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    config = function()
        vim.opt.list = true
        vim.opt.listchars:append("space:⋅")

        local ibl = require("ibl")
        ibl.setup({
            scope = {
                enabled = false,
            },
            indent = { char = "┊" },
        })
    end,
}
