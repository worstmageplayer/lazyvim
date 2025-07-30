return {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        workspaces = {
            {
                name = "obsidian_vault",
                path = "~/Personal/obsidian_vault",
            },
            {
                name = "uni_notes",
                path = "~/Personal/uni_notes",
            },
        },
    },
}
