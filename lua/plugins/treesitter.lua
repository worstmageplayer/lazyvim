return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require('nvim-treesitter.install').compilers = { 'zig' }
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        "java",
        "javascript",
        "typescript",
        "c",
        "css",
        "html",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
      },
      sync_install = false,
      auto_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    }
  end,
}
