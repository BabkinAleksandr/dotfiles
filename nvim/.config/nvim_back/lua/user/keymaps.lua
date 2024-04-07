-- shorten func to be able to add description
local remap = function(mode, before, after, desc)
    desc = desc or ""
    vim.api.nvim_set_keymap(mode, before, after, { noremap = true, silent = true, desc = desc })
end

--Remap space as leader key
remap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
remap("n", "<leader>w", ":w<cr>")
remap("n", "<leader>nn", ":noh<cr>")
-- Better window navigation
-- This is taken over by Tmux navigation plugin
-- remap("n", "<C-h>", "<C-w>h")
-- remap("n", "<C-j>", "<C-w>j")
-- remap("n", "<C-k>", "<C-w>k")
-- remap("n", "<C-l>", "<C-w>l")

-- Tmux
remap("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
remap("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
remap("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
remap("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
-- remap("n", "<C-j>", "<C-w>j")
-- remap("n", "<C-k>", "<C-w>k")
-- remap("n", "<C-l>", "<C-w>l")

remap("n", "<leader>ee", ":NvimTreeToggle<cr>", "Toggle Tree view")
remap("n", "<leader>ef", ":NvimTreeFindFileToggle<cr>", "Find file in a tree")
remap("n", "<leader>ec", ":NvimTreeFindFileToggle<cr>", "Collapse tree")
remap("n", "<leader>er", ":NvimTreeFindFileToggle<cr>", "Refresh tree")
-- remap("n", "<leader>e", ":Lex 30<cr>")

-- Resize with arrows
remap("n", "<A-Up>", ":resize -2<CR>")
remap("n", "<A-Down>", ":resize +2<CR>")
remap("n", "<A-Left>", ":vertical resize +2<CR>")
remap("n", "<A-Right>", ":vertical resize -2<CR>")

-- Navigate buffers
remap("n", "<S-l>", ":bnext<CR>")
remap("n", "<S-h>", ":bprevious<CR>")
remap("n", "<leader>q", ":Bdelete<CR>") -- close buffer

-- Scrolling
remap("n", "<C-d>", "<C-d>zz")
remap("n", "<C-u>", "<C-u>zz")

-- visual --
-- stay in indent mode
remap("v", "<", "<gv")
remap("v", ">", ">gv")

-- Visual Block --
-- Move text up and down
remap("x", "J", ":move '>+1<CR>gv-gv")
remap("x", "K", ":move '<-2<CR>gv-gv")
remap("x", "<A-j>", ":move '>+1<CR>gv-gv")
remap("x", "<A-k>", ":move '<-2<CR>gv-gv")
