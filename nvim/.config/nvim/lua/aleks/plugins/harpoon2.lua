return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        local conf = require("telescope.config").values

        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "Harpoon: Add file" })
        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        vim.keymap.set("n", "<leader>1", function()
            harpoon:list():select(1)
        end, { desc = "Harpoon: Go To 1" })
        vim.keymap.set("n", "<leader>2", function()
            harpoon:list():select(2)
        end, { desc = "Harpoon: Go To 2" })
        vim.keymap.set("n", "<leader>3", function()
            harpoon:list():select(3)
        end, { desc = "Harpoon: Go To 3" })
        vim.keymap.set("n", "<leader>4", function()
            harpoon:list():select(4)
        end, { desc = "Harpoon: Go To 4" })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-p>", function()
            harpoon:list():prev()
        end, { desc = "Harpoon: Prev" })
        vim.keymap.set("n", "<C-n>", function()
            harpoon:list():next()
        end, { desc = "Harpoon: Next" })
    end,
}
