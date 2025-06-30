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
local opts = function(desc) return { desc = desc, noremap = true, silent = true } end

-- File Explorer
map("n", "<leader>q", vim.cmd.Ex, opts(":Ex"))

-- Write and quit
map("n", "<leader>wq", '<cmd>wq<CR>', opts("Write and Quit"))

-- Search next/prev opening brace and center the view
map('n', '<A-[>', [[/\v\{<CR>zz]], opts("Search next '{' and centers"))
map('n', '<A-]>', [[?\v\{<CR>zz]], opts("Search prev '{' and centers"))

-- Scroll half-page and center the cursor
map('n', '<C-u>', [[<C-u><CR>zz]], opts(""))
map('n', '<C-d>', [[<C-d><CR>zz]], opts(""))

-- Next/prev search result and center + open folds
map('n', 'n', [[nzzzv]], opts(""))
map('n', 'N', [[Nzzzv]], opts(""))

-- Paste over selection without yanking it
map('v', 'p', [["_dP]], opts(""))

-- Move selected lines up/down in visual mode
map('v', 'J', ":m '>+1<CR>gv=gv", opts(""))
map('v', 'K', ":m '<-2<CR>gv=gv", opts(""))

-- Join lines without moving the cursor
map('n', 'J', "mzJ`z", opts(""))

-- System clipboard
map('n', '<leader>y', '"+y', opts("Yank to System Clipboard"))
map('v', '<leader>y', '"+y', opts("Yank to System Clipboard"))
map("n", "<leader>p", '"+p', opts("Paste from System Clipboard"))
map("n", "<leader>P", '"+P', opts("Paste from System Clipboard"))

-- Disable accidental Q (Ex mode)
map('n', 'Q', "<nop>", opts(""))

-- Selection
map('n', '<leader>v', [[v]], opts("Visual mode"))
map('n', '<leader>va', [[ggVG]], opts("Visual select all"))
map('n', '<leader>vw', [[viw]], opts("Visual select word"))

-- String
map("v", "<leader>\"", function()
    vim.cmd("normal! <Esc>gv")
    vim.cmd("normal! `<i\"")
    vim.cmd("normal! `>a\"")
end, opts("Wrap selection in double quotes"))
map("v", "<leader>\'", function()
    vim.cmd("normal! <Esc>gv")
    vim.cmd("normal! `<i'")
    vim.cmd("normal! `>a'")
end, opts("Wrap selection in single quotes"))

-- === Telescope ===
local builtin = require('telescope.builtin')
map('n', '<leader>f', builtin.find_files, opts("Telescope find files"))
map('n', '<leader>fl', builtin.find_files, opts("Telescope find files"))
map('n', '<leader>fd', builtin.diagnostics, opts("Telescope diagnostics"))
map('n', '<leader>fg', builtin.git_files, opts("Telescope git files"))
map('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input('Grep: ') })
end, opts("Telescope grep string"))
map('n', '<leader>fc', function()
    builtin.find_files{ cwd = vim.fn.stdpath("config")}
end, opts("Telescope find config files"))

-- === Harpoon2 ===
local harpoon = require('harpoon')
map('n', '<leader>h', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, opts("Harpoon quick menu"))
map('n', '<leader>hl', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, opts("Harpoon quick menu"))
map('n', '<leader>ha', function() harpoon:list():add() end, opts("Harpoon Adds current file"))
map('n', '<leader>j', function() harpoon:list():select(1) end, opts("Harpoon Select 1"))
map('n', '<leader>k', function() harpoon:list():select(2) end, opts("Harpoon Select 2"))
map('n', '<leader>l', function() harpoon:list():select(3) end, opts("Harpoon Select 3"))

vim.keymap.set("n", "<leader>", function()
    local maps = vim.api.nvim_get_keymap("")
    local results = {}

    for _, map in ipairs(maps) do
        if map.lhs:find("^" .. vim.g.mapleader) then
            local desc = map.desc or ""
            local lhs = map.lhs:gsub("^" .. vim.g.mapleader, "<leader>")
            table.insert(results, string.format("%-5s %-15s %s", map.mode, lhs, desc))
        end
    end

    table.sort(results)

    local width = math.max(unpack(vim.tbl_map(function(line) return #line end, results))) + 4
    local height = #results + 2

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, results)

    local win = vim.api.nvim_open_win(buf, true, {
        title = "Leader Mappings",
        title_pos = "center",
        relative = "editor",
        width = width,
        height = height,
        row = (vim.o.lines - height) / 2,
        col = (vim.o.columns - width) / 2,
        border = "rounded",
        style = "minimal",
    })

end, opts("Show <leader> mappings"))
