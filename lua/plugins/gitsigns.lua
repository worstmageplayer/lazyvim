return {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        require('gitsigns').setup {
            signs = {
                add          = { text = '▎' },
                change       = { text = '▎' },
                delete       = { text = '' },
                topdelete    = { text = '' },
                changedelete = { text = '▎' },
                untracked    = { text = '▎' },
            },
            signcolumn = true,
            numhl      = false,
            linehl     = false,
            word_diff  = false,
            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },
            attach_to_untracked = true,
            current_line_blame = false,
            update_debounce = 100,
            status_formatter = nil,
        }
    end,
}
