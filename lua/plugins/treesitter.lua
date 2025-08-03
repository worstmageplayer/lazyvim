return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require('nvim-treesitter.install').compilers = { 'zig' }
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        "javascript",
        "typescript",
        "c",
        "c_sharp",
        "css",
        "html",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "matlab",
        "markdown",
        "markdown_inline",
        "rust",
        "xml",
        "asm",
        "llvm",
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
