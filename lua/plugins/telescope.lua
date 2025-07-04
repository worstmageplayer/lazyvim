return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
