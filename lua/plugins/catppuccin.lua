return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            color_overrides = {
                mocha = {
                    base = "#16161d",
                    text = "#f8f8ff",
                },
                latte = {
                    base = "#fffff0",
                    text = "#16161d",
                },
            },
            highlight_overrides = {
                mocha = function(colors)
                    return {
                        Normal = { bg = "none" },
                        NormalFloat = { bg = "none" },
                        NormalNC = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },
                        StatusLine = { bg = "none" },
                        StatusLineNC = { bg = "none" },
                        MsgArea = { bg = "none" },
                        CursorLine = { bg = "none" },
                        CursorLineNr = { fg = "#ebefff" },
                        LineNr = { fg = "#cdd6f4" },
                        VertSplit = { fg = "#fffff0" },
                        Whitespace = { fg = "#323242" },
                        Visual = {
                            style = {},
                        }
                    }
                end,
                latte = function(colors)
                    return {
                        LineNr = { fg = "#7287fd" },
                        CursorLineNr = { fg = "#7287fd" },
                        CursorLine = { bg = "#e8e8da" },
                        VertSplit = { fg = "#7827fd" },
                        MsgArea = { bg = "#fffff0" },
                    }
                end,
            },
            integrations = {
                aerial = true,
                alpha = true,
                cmp = true,
                dashboard = true,
                flash = true,
                fzf = true,
                grug_far = true,
                gitsigns = true,
                headlines = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                leap = true,
                lsp_trouble = true,
                mason = true,
                markdown = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                neotree = true,
                noice = true,
                notify = true,
                semantic_tokens = true,
                snacks = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
        })

        vim.cmd.colorscheme("catppuccin")
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = 'none' })
      end,
}
