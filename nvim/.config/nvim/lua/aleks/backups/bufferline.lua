return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    opts = {
        options = {
            mode = "tabs",
            -- move = "buffers",
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(count, level)
                local icon = level:match("error") and " " or " "
                return " " .. icon .. count
            end,
            tab_size = 40,
            max_name_length = 40,
            always_show_bufferline = true, -- change to false to entirely hide bufferline
            show_close_icon = false,
            show_buffer_close_icons = false,
            show_tab_indicators = false,
            close_command = "Bdelete! %d",
            right_mouse_command = "Bdelete! %d",
        },
    },
}
