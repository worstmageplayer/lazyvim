-- === Commands ===
vim.api.nvim_create_user_command("GitACP", function()
  vim.ui.input({ prompt = "Commit message: " }, function(msg)
    if not msg or msg == "" then
      vim.notify("Aborted: no commit message", vim.log.levels.WARN)
      return
    end

    vim.cmd("!git add .")
    vim.cmd('!git commit -m "' .. msg:gsub('"', '\\"') .. '"')
    vim.cmd("!git push")
  end)
end, { desc = "Git add . commit and push" })
