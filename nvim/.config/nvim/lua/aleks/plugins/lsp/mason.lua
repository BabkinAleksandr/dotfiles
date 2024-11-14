return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
        mason.setup({})

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                -- "html",
                -- "cssls",
                -- "tailwindcss",
                "lua_ls",
                -- "graphql",
                -- "emmet_ls",
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                -- "prettier", -- prettier formatter
                "stylua", -- lua formatter
                -- "eslint_d",
            },
        })
    end,
}
