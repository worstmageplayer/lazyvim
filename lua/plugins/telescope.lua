return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    {
      '<leader>fl',
      require('telescope.builtin').find_files,
      desc = "Telescope find files"
    },
    {
      '<leader>fd',
      require('telescope.builtin').diagnostics,
      desc = "Telescope diagnostics"
    },
    {
      '<leader>fg',
      require('telescope.builtin').git_files,
      desc = "Telescope git files"
    },
    {
      '<leader>fs',
      require('telescope.builtin').live_grep,
      desc = "Telescope grep string"
    },
    {
      '<leader>fc',
      function ()
        require('telescope.builtin').find_files{ cwd = vim.fn.stdpath("config") }
      end,
      desc = "Telescope config files"
    }
  }
}
