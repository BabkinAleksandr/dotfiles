-- short func to be able to add description
local remap = function(mode, before, after, desc)
    desc = desc or ""
    vim.api.nvim_set_keymap(mode, before, after, { noremap = true, silent = true, desc = desc })
end

--Remap space as leader key
remap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
remap("n", "<leader>w", ":w<cr>", "Write current buffer")
remap("n", "<leader>nn", ":noh<cr>", "Clear current search")

-- Better window navigation
-- This is taken over by Tmux navigation plugin
-- remap("n", "<C-h>", "<C-w>h")
-- remap("n", "<C-j>", "<C-w>j")
-- remap("n", "<C-k>", "<C-w>k")
-- remap("n", "<C-l>", "<C-w>l")

-- Tmux
remap("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", "To left tmux pan")
remap("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", "To right tmux pan")
-- remap("n", "<C-j>", "<C-w>j")
-- remap("n", "<C-k>", "<C-w>k")
-- remap("n", "<C-l>", "<C-w>l")

-- Show netrw on the left side with width of 30
-- See nvim-tree.lua file for more
-- remap("n", "<leader>e", ":Lex 30<cr>")

-- Resize with arrows
remap("n", "<A-Up>", ":resize -2<CR>", "Resize current window horizontally (up)")
remap("n", "<A-Down>", ":resize +2<CR>", "Resize current window horizontally (down)")
remap("n", "<A-Left>", ":vertical resize +2<CR>", "Resize current window vertically (left)")
remap("n", "<A-Right>", ":vertical resize -2<CR>", "Resize current window vertically (right)")

-- Navigate buffers
remap("n", "<S-l>", ":bnext<CR>", "To next buffer")
remap("n", "<S-h>", ":bprevious<CR>", "To previous buffer")
remap("n", "<leader>q", ":Bdelete<CR>", "Close buffer")
-- Navigate tabs
remap("n", "<leader>to", "<cmd>tabnew<CR>", "Open new tab") -- open new tab
remap("n", "<leader>tx", "<cmd>tabclose<CR>", "Close current tab") -- close current tab
remap("n", "<leader>tn", "<cmd>tabn<CR>", "Go to next tab") --  go to next tab
remap("n", "<leader>tp", "<cmd>tabp<CR>", "Go to previous tab") --  go to previous tab
remap("n", "<leader>tf", "<cmd>tabnew %<CR>", "Open current buffer in new tab") --  move current buffer to new tab

-- Scrolling
remap("n", "<C-d>", "<C-d>zz", "Scroll down")
remap("n", "<C-u>", "<C-u>zz", "Scroll up")

-- visual --
-- stay in indent mode
remap("v", "<", "<gv", "Decrease indent")
remap("v", ">", ">gv", "Increase indent")

-- Visual Block --
-- Move text up and down
remap("x", "J", ":move '>+1<CR>gv-gv", "Move selection down")
remap("x", "K", ":move '<-2<CR>gv-gv", "Move selection up")
remap("x", "<A-j>", ":move '>+1<CR>gv-gv", "Move selection right")
remap("x", "<A-k>", ":move '<-2<CR>gv-gv", "Move selection left")
