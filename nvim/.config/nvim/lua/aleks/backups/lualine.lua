return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")

        local hide_in_width = function()
            return vim.fn.winwidth(0) > 80
        end

        local diagnostics = {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            sections = { "error", "warn" },
            symbols = { error = "  ", warn = "  " },
            colored = true,
            update_in_insert = false,
            always_visible = true,
        }

        local filename = {
            "filename",
            file_status = true,
            path = 1,
        }

        local diff = {
            "diff",
            colored = true,
            symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
            cond = hide_in_width,
        }

        local mode = {
            "mode",
            fmt = function(str)
                return " " .. str .. " "
            end,
        }

        local filetype = {
            "filetype",
            icons_enabled = true,
            icon = nil,
        }

        local branch = {
            "branch",
            icons_enabled = true,
            icon = "",
        }

        local spaces = function()
            return "s: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
        end

        local colorscheme = vim.g.colors_name
        local function get_theme()
            if colorscheme and colorscheme == "vague" then
                -- TODO: make a PR to support lualine in `vague` theme
                local colors = require("vague.colors")

                --[[ bg = "#18191a",
                    fg = "#cdcdcd",
                    floatBorder = "#878787",
                    line = "#282830",
                    comment = "#646477",
                    builtin = "#bad1ce",
                    func = "#be8c8c",
                    string = "#deb896",
                    number = "#d2a374",
                    property = "#c7c7d4",
                    constant = "#b4b4ce",
                    parameter = "#b9a3ba",
                    visual = "#363738",
                    error = "#d2788c",
                    warning = "#e6be8c",
                    hint = "#8ca0dc",
                    operator = "#96a3b2",
                    keyword = "#7894ab",
                    type = "#a1b3b9",
                    search = "#465362",
                    plus = "#8faf77",
                    delta = "#e6be8c", ]]
                return {
                    normal = {
                        a = { bg = colors.bg, fg = colors.fg, gui = "bold" },
                        b = { bg = colors.bg, fg = colors.fg },
                        c = { bg = colors.bg, fg = colors.fg },
                    },
                    insert = {
                        a = { bg = colors.string, fg = colors.bg, gui = "bold" },
                        c = { bg = colors.bg, fg = colors.fg },
                    },
                    visual = {
                        a = { bg = colors.property, fg = colors.bg, gui = "bold" },
                        c = { bg = colors.bg, fg = colors.fg },
                    },
                    replace = {
                        a = { bg = colors.error, fg = colors.bg, gui = "bold" },
                        c = { bg = colors.bg, fg = colors.fg },
                    },
                    command = {
                        a = { bg = colors.hint, fg = colors.bg, gui = "bold" },
                        c = { bg = colors.bg, fg = colors.fg },
                    },
                    inactive = {
                        a = { bg = colors.bg, fg = colors.comment, gui = "bold" },
                        c = { bg = colors.bg, fg = colors.comment },
                    },
                }
            end

            return "auto"
        end

        lualine.setup({
            options = {
                icons_enabled = true,
                -- theme = "auto",
                theme = get_theme(),
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
                always_divide_middle = true,
            },
            sections = {
                lualine_a = { mode },
                lualine_b = { branch, diagnostics },
                lualine_c = { filename },
                lualine_x = { diff, spaces, filetype },
                lualine_y = {},
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = {},
        })
    end,
}
