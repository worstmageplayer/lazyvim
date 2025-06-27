return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            color_overrides = {
                all = {
                    base = "#16161d",
                    text = "#f8f8ff",
                }
            },
            custom_highlights = function(colors)
                return {
                    LineNr = { fg = "#fffff0" },
                    CursorLineNr = { fg = "#fffff0" },
                    VertSplit = { fg = "#fffff0" },
                    MsgArea = { bg = "#16161d" },
                }
            end,
        })

        vim.cmd.colorscheme("catppuccin")
    end,
}
