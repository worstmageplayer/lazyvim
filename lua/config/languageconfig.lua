-- === Markdown ===
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set("v", "<leader>b", "<Esc> `>a**<Esc> `<i**<Esc>", { buffer = true })
    vim.keymap.set("v", "<leader>i", "<Esc> `>a*<Esc> `<i*<Esc>", { buffer = true })
    vim.keymap.set("v", "<leader>h1", "<Esc> `<i# <Esc>", { buffer = true })
    vim.keymap.set("v", "<leader>h2", "<Esc> `<i## <Esc>", { buffer = true })
    vim.keymap.set("v", "<leader>h3", "<Esc> `<i### <Esc>", { buffer = true })
    vim.keymap.set("v", "<leader>h4", "<Esc> `<i#### <Esc>", { buffer = true })
    vim.keymap.set("v", "<leader>h5", "<Esc> `<i##### <Esc>", { buffer = true })
    vim.keymap.set("v", "<leader>h6", "<Esc> `<i###### <Esc>", { buffer = true })
  end,
})

-- === lua ===
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2
  end,
})
