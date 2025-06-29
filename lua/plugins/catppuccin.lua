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
                    base = "#fff5ee",
                    text = "#16161d",
                },
            },
            highlight_overrides = {
                mocha = function(colors)
                    return {
                        LineNr = { fg = "#fffff0" },
                        CursorLineNr = { fg = "#f0f0ff" },
                        LineNr = { fg = "#c8c8d7" },
                        VertSplit = { fg = "#fffff0" },
                        MsgArea = { bg = "#16161d" },
                    }
                end,
                latte = function(colors)
                    return {
                        LineNr = { fg = "#7287fd" },
                        CursorLineNr = { fg = "#7827fd" },
                        LineNr = { bg = "#e1d7cd" },
                        VertSplit = { fg = "#7827fd" },
                        MsgArea = { bg = "#fff5ee" },
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
    end,
}
