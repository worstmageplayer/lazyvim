-- === Markdown ===
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.opt.wrap = true
    vim.opt.linebreak = true

    vim.keymap.set("v", "<leader>b", "<Esc> `>a**<Esc> `<i**<Esc>", { buffer = true })
    vim.keymap.set("v", "<leader>i", "<Esc> `>a*<Esc> `<i*<Esc>", { buffer = true })
  end,
})

-- === Lua ===
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2
  end,
})
