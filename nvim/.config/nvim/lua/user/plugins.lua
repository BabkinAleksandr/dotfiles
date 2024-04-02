local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    }
    print 'Installing packer close and reopen Neovim...'
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require('packer.util').float { border = 'rounded' }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    use 'wbthomason/packer.nvim' -- Have packer manage itself
    use 'nvim-lua/popup.nvim'    -- An implementation of the Popup API from vim in Neovim
    use 'nvim-lua/plenary.nvim'  -- Useful lua functions used by lots of plugins
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'windwp/nvim-autopairs'
    use 'numToStr/Comment.nvim'
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }
    use { 'akinsho/bufferline.nvim', tag = '*', requires = 'nvim-tree/nvim-web-devicons' }
    use 'moll/vim-bbye'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    -- use 'ThePrimeagen/vim-be-good'
    use 'yamatsum/nvim-cursorline'
    use { 'echasnovski/mini.starter', branch = 'stable' }
    -- use { 'akinsho/toggleterm.nvim', tag = '*' } -- check if needed. probably tmux is better alternative
    use {
        'NeogitOrg/neogit',
        requires = {
            { 'nvim-lua/plenary.nvim' },         -- required
            { 'nvim-telescope/telescope.nvim' }, -- optional
            { 'sindrets/diffview.nvim' },        -- optional
            { 'ibhagwan/fzf-lua' },              -- optional
        }
    }
    use 'lukas-reineke/indent-blankline.nvim' -- indentation symbols for lines
    use 'christoomey/vim-tmux-navigator'
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
    })
    use 'petertriho/nvim-scrollbar'

    -- Colorschemes
    -- use 'lunarvim/colorschemes'
    use({ 'rose-pine/neovim', as = 'rose-pine' })
    -- use 'gbprod/nord.nvim'
    use { 'catppuccin/nvim', as = 'catppuccin' }
    use 'AlexvZyl/nordic.nvim'

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }
    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-jdtls'

    use { 'folke/which-key.nvim' }

    -- Telescope
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                            , branch = '0.1.x',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        }
    }

    -- Git
    use 'lewis6991/gitsigns.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
