-- === Autocommands ===
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { timeout = 50 }
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})

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

-- Custom keymap helper
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- File Explorer
map("n", "<leader>q", vim.cmd.Ex)

-- Write and quit
map("n", "<leader>wq", '<cmd>wq<CR>')

-- Search next/prev opening brace and center the view
map('n', '<A-[>', [[/\v\{<CR>zz]], opts)
map('n', '<A-]>', [[?\v\{<CR>zz]], opts)

-- Scroll half-page and center the cursor
map('n', '<C-u>', [[<C-u><CR>zz]], opts)
map('n', '<C-d>', [[<C-d><CR>zz]], opts)

-- Next/prev search result and center + open folds
map('n', 'n', [[nzzzv]], opts)
map('n', 'N', [[Nzzzv]], opts)

-- Paste over selection without yanking it
map('v', 'p', [["_dP]], opts)

-- Move selected lines up/down in visual mode
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- Join lines without moving the cursor
map('n', 'J', "mzJ`z", opts)

-- System clipboard
map('n', '<leader>y', '"+y', opts)
map('v', '<leader>y', '"+y', opts)
map("n", "<leader>p", '"+p', opts)
map("n", "<leader>P", '"+P', opts)

-- Disable accidental Q (Ex mode)
map('n', 'Q', "<nop>", opts)

-- Selection
map('n', '<leader>v', [[v]], opts)
map('n', '<leader>va', [[ggVG]], opts)
map('n', '<leader>vw', [[viw]], opts)

-- String
map("v", "<leader>\"", function()
    vim.cmd("normal! <Esc>gv")
    vim.cmd("normal! `<i\"")
    vim.cmd("normal! `>a\"")
end, opts)
map("v", "<leader>\'", function()
    vim.cmd("normal! <Esc>gv")
    vim.cmd("normal! `<i'")
    vim.cmd("normal! `>a'")
end, opts)

-- === Telescope ===
local builtin = require('telescope.builtin')
map('n', '<leader>f', builtin.find_files, opts)
map('n', '<leader>fl', builtin.find_files, opts)
map('n', '<leader>fg', builtin.git_files, opts)
map('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input('Grep > ') })
end, opts)

-- === Harpoon2 ===
local harpoon = require('harpoon')
map('n', '<leader>h', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, opts)
map('n', '<leader>hl', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, opts)
map('n', '<leader>ha', function() harpoon:list():add() end, opts)
map('n', '<leader>j', function() harpoon:list():select(1) end, opts)
map('n', '<leader>k', function() harpoon:list():select(2) end, opts)
map('n', '<leader>l', function() harpoon:list():select(3) end, opts)
