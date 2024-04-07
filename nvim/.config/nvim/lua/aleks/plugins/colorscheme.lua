return {
    "cocopon/iceberg.vim",
    priority = 1000,
    config = function()
        vim.cmd("colorscheme iceberg")
    end,
}
-- return {
--     "AlexvZyl/nordic.nvim",
--     priority = 1000,
--     config = function()
--         local nordic = require("nordic")
--         -- local black = "#171717"
--
--         -- nordic.setup({
--         -- 	on_palette = function(palette)
--         -- 		palette.black0 = black
--         -- 		return palette
--         -- 	end,
--         -- })
--
--         nordic.load()
--     end,
-- }
