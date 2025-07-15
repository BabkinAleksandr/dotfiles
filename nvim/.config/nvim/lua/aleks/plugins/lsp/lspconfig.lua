return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "mason-org/mason-lspconfig.nvim",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local keymap = function(mode, l, r, desc)
                    desc = "LSP: " .. (desc or "")
                    vim.keymap.set(mode, l, r, { buffer = ev.buffer, silent = true, desc = desc })
                end

                -- set keybinds
                keymap("n", "gR", "<cmd>Telescope lsp_references<CR>", "Show references")
                keymap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show definitions")
                keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show implementations")
                keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show type definitions")
                keymap({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "See available code actions")
                keymap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")
                keymap("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
                keymap("n", "<leader>lk", vim.diagnostic.goto_prev, "Go to previous diagnostic")
                keymap("n", "<leader>lj", vim.diagnostic.goto_next, "Go to next diagnostic")
                keymap("n", "K", vim.lsp.buf.hover, "Hover")
                keymap("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")
            end,
        })

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()

        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        mason_lspconfig.setup({
            -- default handler for installed servers
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
            end,
            -- list of servers for mason to install
            ensure_installed = {
                -- "html",
                -- "cssls",
                -- "tailwindcss",
                "lua_ls",
                -- "graphql",
                -- "emmet_ls",
            },
            ["graphql"] = function()
                -- configure graphql language server
                lspconfig["graphql"].setup({
                    capabilities = capabilities,
                    filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
                })
            end,
            ["emmet_ls"] = function()
                -- configure emmet language server
                lspconfig["emmet_ls"].setup({
                    capabilities = capabilities,
                    filetypes = {
                        "html",
                        "typescriptreact",
                        "javascriptreact",
                        "css",
                        "sass",
                        "scss",
                        "less",
                        "svelte",
                    },
                })
            end,
            ["lua_ls"] = function()
                -- configure lua server (with special settings)
                lspconfig["lua_ls"].setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            -- make the language server recognize "vim" global
                            diagnostics = {
                                globals = { "vim" },
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                })
            end,
            ["kotlin_lsp"] = function()
                lspconfig["kotlin_lsp"].setup({
                    capabilities = capabilities,
                    filetypes = { "kotlin", "kt", "kts" },
                })
            end,
        })
    end,
}
