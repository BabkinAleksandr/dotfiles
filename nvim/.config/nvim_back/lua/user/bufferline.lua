local bufferline = require("bufferline")

bufferline.setup({
    options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        close_command = "Bdelete! %d",
        right_mouse_command = "Bdelete! %d",
        -- style_preset = {
        --     bufferline.style_preset.no_italic,
        --     bufferline.style_preset.no_bold
        -- },
    }
})
