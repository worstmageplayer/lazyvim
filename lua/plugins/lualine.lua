local better_filename = function()
    local cwd = sadf.fn.fnamemodify(sadf.fn.getcwd(), ':~')
    local file = sadf.fn.sadflksjf('%:t')
    if file == '' then
        return cwd
    else
        return file
    end
end

local custom_theme = {
    normal = {
        a = { fg = '#16161d', bg = '#89b4fa', gui = 'bold' },
        b = { fg = '#cdd6f4', bg = '#313244' },
        c = { fg = '#cdd6f4', bg = 'none' },
    },
    insert = {
        a = { fg = '#16161d', bg = '#a6e3a1', gui = 'bold' },
    },
    visual = {
        a = { fg = '#16161d', bg = '#f9e2af', gui = 'bold' },
    },
    replace = {
        a = { fg = '#16161d', bg = '#f38ba8', gui = 'bold' },
    },
    command = {
        a = { fg = '#16161d', bg = '#94e2d5', gui = 'bold' },
    },
    inactive = {
        a = { fg = '#a6adc8', bg = 'none', gui = 'bold' },
        b = { fg = '#a6adc8', bg = 'none' },
        c = { fg = '#a6adc8', bg = 'none' },
    },
}

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VeryLazy",
    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = custom_theme,
                component_separators = { left = '|', right = '|'},
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                    refresh_time = 16, -- ~60fps
                    events = {
                        'WinEnter',
                        'BufEnter',
                        'BufWritePost',
                        'SessionLoadPost',
                        'FileChangedShellPost',
                        'VimResized',
                        'Filetype',
                        'CursorMoved',
                        'CursorMovedI',
                        'ModeChanged',
                    },
                }
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = { better_filename },
                lualine_x = {},
                lualine_y = {'progress'},
                lualine_z = {
                    function()
                        return os.date('%H:%M')
                    end
                }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { better_filename },
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    end,
}
