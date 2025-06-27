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
                    CursorLineNr = { fg = "#ffffff" },
                    VertSplit = { fg = "#fffff0" },
                }
            end,
        })

        vim.cmd.colorscheme("catppuccin")
    end,
}
