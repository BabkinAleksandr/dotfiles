local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("gD", vim.lsp.buf.declaration, 'Go to Declaration')
    nmap("gD", vim.lsp.buf.definition, 'Go to Declaration')
    -- nmap("gd", "<cmd>Telescope lsp_definitions<cr>", 'Go to Definition')
    nmap("K", vim.lsp.buf.hover, 'Hover')
    nmap("gI", vim.lsp.buf.implementation, 'Go to Implementation')
    nmap("gr", "<cmd>Telescope lsp_references<cr>", 'Show references')
    nmap("gl", vim.diagnostic.open_float, 'Open float')
    nmap("<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", 'Format code')
    nmap("<leader>li", "<cmd>LspInfo<cr>", 'Info')
    nmap("<leader>lI", "<cmd>LspInstallInfo<cr>", 'Install Info')
    nmap("<leader>la", vim.lsp.buf.code_action, 'Code actions')
    nmap("<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", 'Next diagnostics')
    nmap("<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", 'Prev diagnostics')
    nmap("<leader>rn", vim.lsp.buf.rename, 'Rename')
    nmap("<leader>ls", vim.lsp.buf.signature_help, 'Signature help')
    -- nmap("<leader>lq",  vim.diagnostic.setloclist, '')
end)

lsp.set_sign_icons({
    error = '',
    warn = '',
    hint = '»',
    info = '»'
})

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').kotlin_language_server.setup {}
require('lspconfig').clangd.setup {
    indentWidth = 4
}

lsp.setup()
