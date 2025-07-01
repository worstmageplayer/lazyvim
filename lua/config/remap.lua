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

-- <leader> mappings
map("n", "<leader>", function()
    local maps = vim.api.nvim_get_keymap("")
    local results = {}
    local raw_keys = {}
    local modes = {}

    for _, map in ipairs(maps) do
        if map.lhs:find("^" .. vim.g.mapleader) then
            local desc = map.desc or ""
            local lhs = map.lhs:gsub("^" .. vim.g.mapleader, "<leader>")
            table.insert(results, string.format("%-5s %-15s %s", map.mode, lhs, desc))
            table.insert(raw_keys, map.lhs)
            table.insert(modes, map.mode)
        end
    end

    table.sort(results, function(a, b)
        return a:lower() < b:lower()
    end)

    local width = math.max(unpack(vim.tbl_map(function(line) return #line end, results))) + 4
    local height = #results

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, results)
    vim.api.nvim_buf_set_option(buf, "modifiable", false)

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

    vim.keymap.set("n", "<Esc>", function()
        vim.api.nvim_win_close(win, true)
    end, { silent = true, buffer = buf })

end, opts("Show <leader> mappings"))

map("n", "K", function()
    local word = vim.fn.expand("<cword>")

    local ok = pcall(vim.cmd, "help " .. word)
    if not ok then
        vim.notify("No help found for: " .. word, vim.log.levels.WARN)
        return
    end

    local help_win = vim.api.nvim_get_current_win()
    local help_buf = vim.api.nvim_get_current_buf()

    local help_lines = vim.api.nvim_buf_get_lines(help_buf, 0, -1, false)
    local cursor_pos = vim.api.nvim_win_get_cursor(0)

    vim.api.nvim_win_close(help_win, true)

    local float_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, help_lines)
    vim.api.nvim_buf_set_option(float_buf, "filetype", "help")
    vim.api.nvim_buf_set_option(float_buf, "modifiable", false)

    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local float_win = vim.api.nvim_open_win(float_buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
        title = "Help: " .. word,
        title_pos = "center",
    })

    vim.api.nvim_win_set_cursor(0, cursor_pos)

    -- Close with <Esc>
    vim.keymap.set("n", "<Esc>", function()
        vim.api.nvim_win_close(float_win, true)
    end, { buffer = float_buf, nowait = true, silent = true })
end, opts("Floating help"))

-- Refactor
map("n", "<leader>rs", function()
    vim.ui.input({ prompt = "Search: " }, function(search)
        if not search or search == "" then return end

        vim.ui.input({ prompt = "Replace: " }, function(replace)
            if not replace then return end

            local cmd = string.format("%%s/%s/%s/gc", search, replace)
            vim.cmd(cmd)
        end)
    end)
end, opts("Replace search"))
map("n", "<leader>rw", function()
    local word = vim.fn.expand("<cword>")

    vim.ui.input({ prompt = "Replace '" .. word .. "' with: " }, function(replace)
        if not replace or replace == "" then return end

        word = "\\<" .. word .. "\\>"
        local cmd = string.format("%%s/%s/%s/gc", word, replace)
        vim.cmd(cmd)
    end)
end, opts("Replace word under cursor"))

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
map('v', 'p', [["_dP]], opts("Paste over selection without yanking it"))

-- Move selected lines up/down in visual mode
map('v', 'J', ":m '>+1<CR>gv=gv", opts("Move selected lines up"))
map('v', 'K', ":m '<-2<CR>gv=gv", opts("Move selected lines down"))

-- Join lines without moving the cursor
map('n', 'J', "mzJ`z", opts("Join lines without moving the cursor"))

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

-- Text Surround
map("v", "<leader>\"", "<Esc> `>a\"<Esc> `<i\"<Esc>", opts("Surround selection in double quotes"))
map("v", "<leader>\'", "<Esc> `>a\'<Esc> `<i\'<Esc>", opts("Surround selection in single quotes"))
map("v", "<leader>(", "<Esc> `>a)<Esc> `<i(<Esc>", opts("Surround selection in parenthesis"))
map("v", "<leader>{", "<Esc> `>a}<Esc> `<i{<Esc>", opts("Surround selection in curly braces"))
map("v", "<leader>[", "<Esc> `>a]<Esc> `<i[<Esc>", opts("Surround selection in square brackets"))

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
map('n', '<leader>ha', function() harpoon:list():add() end, opts("Harpoon add current file"))
map('n', '<leader>j', function() harpoon:list():select(1) end, opts("Harpoon select 1"))
map('n', '<leader>k', function() harpoon:list():select(2) end, opts("Harpoon select 2"))
map('n', '<leader>l', function() harpoon:list():select(3) end, opts("Harpoon select 3"))
