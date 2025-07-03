-- === Markdown ===
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.opt.wrap = true

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

-- === Lua ===
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2

    vim.keymap.set("v", "<leader>c", function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
      local start_line = vim.fn.line("'<") - 1
      local end_line = vim.fn.line("'>")
      local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)

      for i, line in ipairs(lines) do
        if line:find("^%s*%-%-") then
          lines[i] = line:gsub("^%s*%-%-%s?", "", 1)
        else
          lines[i] = "-- " .. line
        end
      end

      vim.api.nvim_buf_set_lines(0, start_line, end_line, false, lines)
    end, { buffer = true })

  end,
})

-- === JavaScript ===
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript: "},
  callback = function()
    vim.keymap.set("v", "<leader>c", function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
      local start_line = vim.fn.line("'<") - 1
      local end_line = vim.fn.line("'>")
      local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)

      for i, line in ipairs(lines) do
        if line:find("^%s*//") then
          lines[i] = line:gsub("^%s*//%s?", "", 1)
        else
          lines[i] = "// " .. line
        end
      end

      vim.api.nvim_buf_set_lines(0, start_line, end_line, false, lines)
    end, { buffer = true })

  end,
})
