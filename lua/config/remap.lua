-- Set <leader> key
vim.g.mapleader = " "

-- === UI Settings ===
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.o.showtabline = 0
vim.o.cursorline = true

-- === Tabs & Indentation ===
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.list = true
vim.opt.listchars = {
    space = "·",
    tab = "»·",
    trail = "·",
    extends = "→",
    precedes = "←",
}

-- === Autocommands ===
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { timeout = 50 }
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
end, { desc = "Git add . && commit && push" })

-- File Explorer
vim.keymap.set("n", "<leader>pp", vim.cmd.Ex)

-- Custom keymap helper
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }

-- Search next/prev opening brace and center the view
map('n', '<A-[>', [[/\v\{<CR>zz]], opts)
map('n', '<A-]>', [[?\v\{<CR>zz]], opts)

-- Scroll half-page and center the cursor
map('n', '<C-u>', [[<C-u><CR>zz]], opts)
map('n', '<C-d>', [[<C-d><CR>zz]], opts)

-- Next/prev search result and center + open folds
map('n', 'n', [[nzzzv]], opts)
map('n', 'N', [[Nzzzv]], opts)

-- Better vertical movement in visual mode (handle wrapped lines)
map('v', 'j', 'gj', opts)
map('v', 'k', 'gk', opts)

-- Paste over selection without yanking it
map('v', 'p', [["_dP]], opts)

-- Move selected lines up/down in visual mode
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- Join lines without moving the cursor
map('n', 'J', "mzJ`z", opts)

-- Yank to system clipboard
map('n', '<leader>y', "\"+y", opts)
map('v', '<leader>y', "\"+y", opts)

-- Paste from system clipboard
map("n", "<leader>p", '"+p', opts)
map("n", "<leader>P", '"+P', opts)

-- Disable accidental Q (Ex mode)
map('n', 'Q', "<nop>", opts)

-- Select all
map('n', '<leader>a', [[ggVG]], opts)
